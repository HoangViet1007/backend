<?php

namespace App\Services;

use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\ForbiddenException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Mail\CustormCancel;
use App\Mail\PTCantTeach;
use App\Mail\PtThough;
use App\Models\Bill;
use App\Models\Course;
use App\Models\CoursePlanes;
use App\Models\CourseStudent;
use App\Models\Schedule;
use App\Models\Stage;
use App\Models\User;
use App\Trait\RoleAndPermissionTrait;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;

/**
 * @Author apple
 * @Date   Oct 31, 2021
 */
class CourseStudentService extends BaseService
{
    use RoleAndPermissionTrait;

    function createModel(): void
    {
        $this->model = new CourseStudent();
    }

    public function getAllCourseStidentByPt()
    {
        $userIdLogin = Auth::user();
        $data        = $this->queryHelper->buildQuery($this->model)
                                         ->with(['users', 'courses'])
                                         ->join('users', 'users.id', 'course_students.user_id')
                                         ->join('courses', 'courses.id', 'course_students.course_id')
                                         ->where('courses.created_by', '=', $userIdLogin['id'])
                                         ->select('course_students.*')
                                         ->get();
        try {
            $response = $data;

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // lay bai hoc tung course student
    public function getCoursePlanByCourseStudent($id)
    {
        // check xem course co phai cua user dang logjn hay ko
        $user          = Auth::user();
        $courseStudent = CourseStudent::find($id);

        if ($courseStudent) {
            if (!($courseStudent->user_id == $user['id'])) {
                throw new BadRequestException(
                    ['message' => __("B??i h???c kh??ng t???n t???i !")], new Exception()
                );
            }
        }

        $stageArray = Stage::where('course_id', $courseStudent->course_id)->pluck('id')->toArray();
        if ($stageArray) {
            $coursePlan = CoursePlanes::whereIn('stage_id', $stageArray)
                                      ->with(['schedules' => function ($q) use ($id) {
                                          $q->where('schedules.course_student_id', $id);
                                      }])
                                      ->select('course_planes.*')->get();

            return $coursePlan;

        } else {
            throw new BadRequestException(
                ['message' => __("B??i h???c kh??ng t???n t???i !")], new Exception()
            );
        }
    }

    public function getAllCourseStudent()
    {
        if (!$this->hasPermission(PermissionConstant::student(ActionConstant::LIST)))
            throw new ForbiddenException(__('Access denied'), new Exception());
        try {
            $data = $this->queryHelper->buildQuery($this->model)
                                      ->join('courses', 'courses.id', 'course_students.course_id')
                                      ->join('users','users.id','course_students.user_id')
                                      ->with(['schedules', 'users','courses.teacher'])
                                      ->select('course_students.*');

            return $data->get();
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function customerCancel(object $request, $id)
    {

        $this->doValidate($request,
                          [
                              'description' => 'required|min:3'
                          ],
                          [
                              'description.required' => 'H??y nh???p l?? do hu??? kho?? h???c !',
                              'description.min'      => 'L?? do ph???i t???i thi???u 3 k?? t??? tr??? l??n !',
                          ]
        );
        $courseStudent = CourseStudent::find($id);
        if ($courseStudent->status == StatusConstant::UNSCHEDULED) {

            $courseStudent->update([
                                       'description' => $request->description,
                                       'status'      => StatusConstant::CANCELED
                                   ]);
            // hoan lai tien 95% kho hoc
            $courseId     = $courseStudent->course_id;
            $course       = Course::find($courseId);
            $price_course = (int)$course->price * 0.95;
            $user         = User::find($courseStudent->user_id);
            $user->update(['money' => $price_course]);

            // g???i email cho ng?????i d??ng
            // email
            $teacher      = User::find($course->created_by);
            $teacherEmail = $teacher->email;
            $teacher_name = $teacher->name;
            $student_name = $user->name;
            $name_course  = $course->name;
            $created_at   = $courseStudent->created_at;
            $description  = $request->description;
            Mail::to($teacherEmail)->send(new CustormCancel($teacher_name, $student_name, $name_course, $created_at,
                                                            $description));

            return CourseStudent::find($id);
        } else {
            throw new BadRequestException(
                ['message' => __("B???n kh??ng th??? hu??? kho?? h???c !")], new Exception()
            );
        }
    }

    public function createCourseStudent(object $request)
    {
        $course_ids = Course::all()->pluck('id')->toArray();
        $user       = User::find(Auth::id());

        $this->doValidate(
            $request,
            [
                'course_id' => 'in:' . implode(',', $course_ids),
                'money'     => 'required|numeric|lt:' . $user->money,
            ],
            [
                'course_id.in'   => 'Kh??ng t???n t???i kh??a h???c!',
                'money.required' => 'Kh??ng c?? s??? ti???n !',
                'money.numeric'  => 'S??? ti???n kh??ng h???p l??? !',
                'money.lt'       => 'S??? ti???n trong v?? kh??ng ????? ????? mua kh??a h???c !',
            ]
        );
        $billData = [
            "code_bill" => date("YmdHis") . Auth::id(), // vnp_TxnRef
            "time"      => date('Y-m-d H:i:s'),
            "money"     => $request->money,
            "status"    => StatusConstant::WALLET,
            "course_id" => $request->course_id,
            "user_id"   => Auth::id()
        ];
        //             them vao bang hoc vien
        $courseStudentData = [
            "status"    => StatusConstant::UNSCHEDULED,
            "user_id"   => Auth::id(),
            "course_id" => $request->course_id
        ];
        $user->update([
                          'money' => $user->money - $request->money,
                      ]);
        CourseStudent::create($courseStudentData);
        $bill    = Bill::create($billData);
        $billRel = Bill::with('course', 'user')->where('bills.id', $bill->id)->first();

        return $billRel;

    }

    public function ptCancel(object $request, $id)
    {
        $this->doValidate($request,
                          [
                              'description' => 'required|min:3'
                          ],
                          [
                              'description.required' => 'H??y nh???p l?? do hu??? kho?? h???c !',
                              'description.min'      => 'L?? do ph???i t???i thi???u 3 k?? t??? tr??? l??n !',
                          ]
        );

        $courseStudent = CourseStudent::find($id);
        if ($courseStudent->status == StatusConstant::UNSCHEDULED) {
            $courseStudent->update([
                                       'description' => $request->description,
                                       'status'      => StatusConstant::CANCELEDBYPT
                                   ]);

            // hoan lai tien 100 kho hoc
            $courseId     = $courseStudent->course_id;
            $course       = Course::find($courseId);
            $price_course = (int)$course->price;
            $user         = User::find($courseStudent->user_id);
            $user->update(['money' => $price_course]);

            // g???i email cho ng?????i d??ng
            $emailCustomer = $user->email;
            $student_name  = $user->name;
            $time_study    = date('y-m-d');
            $name_couser   = $course->name;
            $created_at    = $courseStudent->created_at;

            Mail::to($emailCustomer)->send(new PTCantTeach($student_name, $time_study, $name_couser, $created_at));

            return CourseStudent::find($id);
        } else {
            throw new BadRequestException(
                ['message' => __("B???n kh??ng th??? hu??? kho?? h???c khi ??ang trong tr???ng th??i ??ang h???c !")], new Exception()
            );
        }
    }

    // sent request customer (guiw yeu cau xac nhan dong ys lich hoc)
    public function sentRequestCustomer(object $request, $id)
    {
        $course_student = CourseStudent::find($id);
        if (!$course_student) {
            throw new BadRequestException(
                ['message' => __("H???c vi??n n??y kh??ng t???n t???i !")], new Exception()
            );
        }
        if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
            throw new BadRequestException(
                ['message' => __("Ch??? g???i y??u c???u x??c nh???n l???ch h???c cho ng?????i d??ng khi ??ang ??? tr???ng th??i ch??? x???p l???ch !")],
                new Exception()
            );
        }

        /* phai them du so buo thi moi gui dc y??u c???u cho ng?????i d??ng
         * */
        if (!($this->getCountScheduleForCourseStudent($id) == $this->getCountCoursePlanOff($course_student->course_id))) {
            throw new BadRequestException(
                ['message' => __("G???i y??u c???u cho ng?????i d??ng th???t b???i, h??y th??m l???ch cho ????? s??? bu???i h???c tr???c tuy???n !")],
                new Exception()
            );
        }

        $course_student->update(['user_consent' => StatusConstant::SENT]);

        return true;
    }

    // customer ok
    public function userAgreesCourseStudent(object $request, $id)
    {
        $course_student = CourseStudent::find($id);
        if (!$course_student) {
            throw new BadRequestException(
                ['message' => __("H???c vi??n n??y kh??ng t???n t???i !")], new Exception()
            );
        }
        if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
            throw new BadRequestException(
                ['message' => __("Ch??? g???i y??u c???u x??c nh???n l???ch h???c cho ng?????i d??ng khi ??ang ??? tr???ng th??i ch??? x???p l???ch !")],
                new Exception()
            );
        }
        $course_student->update(['user_consent' => StatusConstant::USERAGREES]);

        // update g???i emai cho ng?????i d??ng

        return true;
    }

    //customer ko ok
    public function userDisAgreesCourseStudent(object $request, $id)
    {
        $course_student = CourseStudent::find($id);
        if (!$course_student) {
            throw new BadRequestException(
                ['message' => __("H???c vi??n n??y kh??ng t???n t???i !")], new Exception()
            );
        }
        if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
            throw new BadRequestException(
                ['message' => __("Ch??? g???i y??u c???u x??c nh???n l???ch h???c cho ng?????i d??ng khi ??ang ??? tr???ng th??i ch??? x???p l???ch !")],
                new Exception()
            );
        }
        $course_student->update(['user_consent' => StatusConstant::USERDISAGREES]);

        return true;
    }

    public function getCourseForCustomer()
    {
        $user_id = Auth::user();
        try {
            $data     = $this->queryHelper->buildQuery($this->model)
                                          ->with(['courses.teacher', 'schedules'])
                                          ->join('courses', 'courses.id', 'course_students.course_id')
                                          ->join('users', 'users.id', 'courses.created_by')
                                          ->select('course_students.*')
                                          ->where('course_students.user_id', '=', $user_id['id']);
            $response = $data->get();

            return $response;

        } catch (Exception $exception) {
            throw new BadRequestException(
                ['message' => __("Kh??ng t???n t???i kho?? h???c !")], new Exception()
            );
        }
    }

    // l???y danh s??ch kh??a h???c ???? d???y xong v?? g???i y??u c???u l??n admin
    public function getCourseStudentRequestAdminForAdmin()
    {
        if (!$this->hasPermission(PermissionConstant::payment(ActionConstant::LIST)))
            throw new ForbiddenException(__('Access denied'), new Exception());
        try {
            $data     = $this->queryHelper->buildQuery($this->model)
                                          ->with(['courses.teacher', 'schedules', 'users'])
                                          ->join('courses', 'courses.id', 'course_students.course_id')
                                          ->join('users', 'users.id', 'courses.created_by')
                                          ->select('course_students.*', 'users.name as userName',
                                                   'courses.name as courseName')
                                          ->where('course_students.status', '=', StatusConstant::REQUESTADMIN);
            $response = $data->paginate(QueryHelper::limit());

            return $response;

        } catch (Exception $exception) {
            throw new BadRequestException(
                ['message' => __("Kh??ng th??nh c??ng !")], new Exception()
            );
        }
    }

    // l???y danh s??ch kh??a h???c ???? d???y xong v?? g???i y??u c???u l??n admin ngo??i m??n PT
    public function getCourseStudentRequestAdminForPt()
    {
        $userId = $this->currentUser()->id ?? null;
        try {
            $data     = $this->queryHelper->buildQuery($this->model)
                                          ->with(['courses.teacher', 'schedules', 'users'])
                                          ->join('courses', 'courses.id', 'course_students.course_id')
                                          ->join('users', 'users.id', 'courses.created_by')
                                          ->select('course_students.*', 'users.name as userName',
                                                   'courses.name as courseName')
                                          ->where('course_students.status', '=', StatusConstant::REQUESTADMIN)
                                          ->where('courses.created_by', '=', $userId);
            $response = $data->paginate(QueryHelper::limit());

            return $response;

        } catch (Exception $exception) {
            throw new BadRequestException(
                ['message' => __("Kh??ng th??nh c??ng !")], new Exception()
            );
        }
    }

    // l???y 1 course student ????? in v??o h??a ????n thanh to??n cho pt theo id truy???n l??n
    public function getCourseStudentById($id)
    {
        $data = $this->queryHelper->buildQuery($this->model)
                                  ->with(['courses.teacher', 'schedules', 'users'])
                                  ->join('courses', 'courses.id', 'course_students.course_id')
                                  ->join('users', 'users.id', 'courses.created_by')
                                  ->select('course_students.*', 'users.name as userName', 'courses.name as courseName')
                                  ->where('course_students.id', '=', $id)
                                  ->get();

        return $data;
    }

    // duyet dang ki
    public function ptThough(object $request, $id)
    {
        $course_student = CourseStudent::find($id);

        if ($course_student) {
            $user_id   = $course_student->user_id;
            $course_id = $course_student->course_id;

            // check xem co phai course cua no ko
            $userIDCourse = Course::find($course_id)->created_by;
            $userLogin    = Auth::user();
            if (!($userLogin['id'] == $userIDCourse)) {
                throw new BadRequestException(
                    ['message' => __("????ng k?? kh??ng t???n t???i !")],
                    new Exception()
                );
            }

            // status ph???i  = Unschedule
            if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
                throw new BadRequestException(
                    ['message' => __("Kh??ng th??? duy???t kho?? h???c trong khi ??ang kh??ng ??? tr???ng th??i ch??? l??n l???ch !")],
                    new Exception()
                );
            }

            // // check duyet tuan tu
            // if ($this->getCourseStudentOldEst($id) == false) {
            //     throw new BadRequestException(
            //         ['message' => __("Kh??ng th??? duy???t ????ng k?? n??y, h??y duy???t m???t c??ch tu???n t??? !")],
            //         new Exception()
            //     );
            // }

            /*
             * khi duy??t khoa hoc ????? h???c vi??n b???t ?????u h???c th?? c???n ph???i th??m ????? l???ch cho nh???ng bu???i h???c off
             * check t???ng s??? bu???i h???c off = t???ng s??? l???ch h???c ???? l??n  (v?? d??? c?? 5 bu???i off = 5 l???ch
            * */
            if (!($this->getCountScheduleForCourseStudent($id) == $this->getCountCoursePlanOff($course_id))) {
                throw new BadRequestException(
                    ['message' => __("Kh??ng th??? duy???t kho?? h???c, h??y th??m l???ch cho ????? s??? bu???i h???c tr???c tuy???n !")],
                    new Exception()
                );
            }

            /* check duyet khoa hoc khi co su dong ?? cu nguoi dung
             * user_consent = UserAgrees
             * */
            if ($course_student->user_consent != StatusConstant::USERAGREES) {
                throw new BadRequestException(
                    ['message' => __("Kh??ng th??? duy???t kho?? h???c khi ch??a c?? s??? ?????ng ?? t??? ph??a ng?????i d??ng !")],
                    new Exception()
                );
            }
            // update duyet dang ki
            $course_student->update(['status' => StatusConstant::SCHEDULE]);

            // g???i mail
            $customer = User::find($course_student->user_id);
            $course   = Course::find($course_student->course_id);

            $emailCustomer = $customer->email;
            $student_name  = $customer->name;
            $created_at    = $course_student->created_at;
            $name_course   = $course->name;
            $teacher_name  = User::find($course->created_by)->name;

            Mail::to($emailCustomer)->send(new PtThough($student_name, $created_at, $teacher_name, $name_course));

            return $course_student;
        }

        throw new BadRequestException(
            ['message' => __("????ng k?? kh??ng t???n t???i !")],
            new Exception()
        );
    }

    // admin through
    public function sendAdminThrough(object $request, $id)
    {
        $course_student = CourseStudent::find($id);
        if ($course_student) {
            $course_id = $course_student->course_id;

            // check xem co phai course cua no ko
            $userIDCourse = Course::find($course_id)->created_by;
            $userLogin    = Auth::user();
            if (!($userLogin['id'] == $userIDCourse)) {
                throw new BadRequestException(
                    ['message' => __("G???i y??u c???u cho admin kh??ng th??nh c??ng !")],
                    new Exception()
                );
            }

            // status ph???i  = Unschedule
            if ($course_student->status != StatusConstant::SCHEDULE) {
                throw new BadRequestException(
                    ['message' => __("Kh??ng th??? g???i y??u c???u duy???t trong khi kh??ng ??? tr???ng th??i ??ang h???c !")],
                    new Exception()
                );
            }

            // check xem dang ki nay d?? du so buoi hoc thanh cong ma o co khieu lai
            if (!($this->getCountScheduleComplete($id) == $this->getCountCoursePlanOff($course_id))) {
                throw new BadRequestException(
                    ['message' => __("Kho?? h???c ch??a k???t th??c ho???c c?? th??? kho?? h???c ??ang c?? s??? khi??u n???i t??? ng?????i d??ng !")],
                    new Exception()
                );
            }
            // update course_student
            $course_student->update(['status' => StatusConstant::REQUESTADMIN]);

            return $course_student;
        }
        throw new BadRequestException(
            ['message' => __("G???i y??u c???u cho admin kh??ng th??nh c??ng !")],
            new Exception()
        );
    }



    // l???y za s??? l???ch x???p cho nh???ng bu???i h???c off c???a khoa hoc c???a customer
    /* xem l???i -> dem schedule th??ng qua course_student_id -> where n?? xong count
     * */
    public function getCountSchedule($course_id, $course_student_id, $status = null)
    {
        $stageId     = Stage::where('course_id', $course_id)->pluck('id')->toArray();
        $course_plan = CoursePlanes::whereIn('stage_id', $stageId)->where('type', 0)->pluck('id')->toArray();
        $schedules   = Schedule::whereIn('course_plan_id', $course_plan)
                               ->where('course_student_id', $course_student_id)
                               ->when($status, function ($q) use ($status) {
                                   $q->where('status', $status);
                               })->count();

        return $schedules;
    }

    public function getCountScheduleForCourseStudent($course_student_id)
    {
        $schedule = Schedule::where('course_student_id', $course_student_id)->count();

        return $schedule;
    }

    public function getCountScheduleComplete($course_student_id)
    {
        $schedule = Schedule::where('course_student_id', $course_student_id)
                            ->where('status', StatusConstant::COMPLETE)
                            ->where('complain', StatusConstant::NOCOMPLAINTS)
                            ->count();

        return $schedule;
    }

    public function getCountCoursePlanOff($course_id)
    {
        $stageId     = Stage::where('course_id', $course_id)->pluck('id')->toArray();
        $course_plan = CoursePlanes::whereIn('stage_id', $stageId)->where('type', 0)->where('status',StatusConstant::ACTIVE)->count();

        return $course_plan;
    }

    public function getCourseStudentOldEst($id_course_student_though)
    {
        /*  lay za created_at cua course_student min
         *  so sanh voi created_at course_student dang muon duyet
         * */
        try {
            $courseStudentThough = CourseStudent::find($id_course_student_though);
            $createdAtThough     = $courseStudentThough->created_at->format('Y-m-d H:i:s');

            // get create min in course_student
            $courseStudent             = CourseStudent::join('courses', 'courses.id', 'course_students.course_id')
                                                      ->where('course_students.status', StatusConstant::UNSCHEDULED)
                                                      ->where('courses.created_by', $this->currentUser()->id)
                                                      ->orderBy('course_students.created_at', 'asc')
                                                      ->select('course_students.*')
                                                      ->first();
            $courseStudentMinCreatedAt = $courseStudent->created_at->format('Y-m-d H:i:s');

            if (!($createdAtThough <= $courseStudentMinCreatedAt)) {
                return false;
            }

            return true;

        } catch (Exception $exception) {
            throw new BadRequestException(
                ['message' => __("Kh??ng th??? duy???t ????ng k?? n??y, h??y duy???t m???t c??ch tu???n t??? !")],
                new Exception()
            );
        }
    }

}
