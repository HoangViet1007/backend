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
                    ['message' => __("Bài học không tồn tại !")], new Exception()
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
                ['message' => __("Bài học không tồn tại !")], new Exception()
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
                              'description.required' => 'Hãy nhập lí do huỷ khoá học !',
                              'description.min'      => 'Lí do phải tối thiểu 3 kí tự trở lên !',
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

            // gửi email cho người dùng
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
                ['message' => __("Bạn không thể huỷ khoá học !")], new Exception()
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
                'course_id.in'   => 'Không tồn tại khóa học!',
                'money.required' => 'Không có số tiền !',
                'money.numeric'  => 'Số tiền không hợp lệ !',
                'money.lt'       => 'Số tiền trong ví không đủ để mua khóa học !',
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
                              'description.required' => 'Hãy nhập lí do huỷ khoá học !',
                              'description.min'      => 'Lí do phải tối thiểu 3 kí tự trở lên !',
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

            // gửi email cho người dùng
            $emailCustomer = $user->email;
            $student_name  = $user->name;
            $time_study    = date('y-m-d');
            $name_couser   = $course->name;
            $created_at    = $courseStudent->created_at;

            Mail::to($emailCustomer)->send(new PTCantTeach($student_name, $time_study, $name_couser, $created_at));

            return CourseStudent::find($id);
        } else {
            throw new BadRequestException(
                ['message' => __("Bạn không thể huỷ khoá học khi đang trong trạng thái đang học !")], new Exception()
            );
        }
    }

    // sent request customer (guiw yeu cau xac nhan dong ys lich hoc)
    public function sentRequestCustomer(object $request, $id)
    {
        $course_student = CourseStudent::find($id);
        if (!$course_student) {
            throw new BadRequestException(
                ['message' => __("Học viên này không tồn tại !")], new Exception()
            );
        }
        if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
            throw new BadRequestException(
                ['message' => __("Chỉ gửi yêu cầu xác nhận lịch học cho người dùng khi đang ở trạng thái chờ xếp lịch !")],
                new Exception()
            );
        }

        /* phai them du so buo thi moi gui dc yêu cầu cho người dùng
         * */
        if (!($this->getCountScheduleForCourseStudent($id) == $this->getCountCoursePlanOff($course_student->course_id))) {
            throw new BadRequestException(
                ['message' => __("Gửi yêu cầu cho người dùng thất bại, hãy thêm lịch cho đủ số buổi học trực tuyến !")],
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
                ['message' => __("Học viên này không tồn tại !")], new Exception()
            );
        }
        if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
            throw new BadRequestException(
                ['message' => __("Chỉ gửi yêu cầu xác nhận lịch học cho người dùng khi đang ở trạng thái chờ xếp lịch !")],
                new Exception()
            );
        }
        $course_student->update(['user_consent' => StatusConstant::USERAGREES]);

        // update gửi emai cho người dùng

        return true;
    }

    //customer ko ok
    public function userDisAgreesCourseStudent(object $request, $id)
    {
        $course_student = CourseStudent::find($id);
        if (!$course_student) {
            throw new BadRequestException(
                ['message' => __("Học viên này không tồn tại !")], new Exception()
            );
        }
        if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
            throw new BadRequestException(
                ['message' => __("Chỉ gửi yêu cầu xác nhận lịch học cho người dùng khi đang ở trạng thái chờ xếp lịch !")],
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
                ['message' => __("Không tồn tại khoá học !")], new Exception()
            );
        }
    }

    // lấy danh sách khóa học đã dạy xong và gửi yêu cầu lên admin
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
                ['message' => __("Không thành công !")], new Exception()
            );
        }
    }

    // lấy danh sách khóa học đã dạy xong và gửi yêu cầu lên admin ngoài màn PT
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
                ['message' => __("Không thành công !")], new Exception()
            );
        }
    }

    // lấy 1 course student để in vào hóa đơn thanh toán cho pt theo id truyển lên
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
                    ['message' => __("Đăng ký không tồn tại !")],
                    new Exception()
                );
            }

            // status phải  = Unschedule
            if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
                throw new BadRequestException(
                    ['message' => __("Không thể duyệt khoá học trong khi đang không ở trạng thái chờ lên lịch !")],
                    new Exception()
                );
            }

            // // check duyet tuan tu
            // if ($this->getCourseStudentOldEst($id) == false) {
            //     throw new BadRequestException(
            //         ['message' => __("Không thể duyệt đăng ký này, hãy duyệt một cách tuần tự !")],
            //         new Exception()
            //     );
            // }

            /*
             * khi duyêt khoa hoc để học viên bắt đầu học thì cần phải thêm đủ lịch cho những buổi học off
             * check tổng số buổi học off = tổng số lịch học đã lên  (ví dụ có 5 buổi off = 5 lịch
            * */
            if (!($this->getCountScheduleForCourseStudent($id) == $this->getCountCoursePlanOff($course_id))) {
                throw new BadRequestException(
                    ['message' => __("Không thể duyệt khoá học, hãy thêm lịch cho đủ số buổi học trực tuyến !")],
                    new Exception()
                );
            }

            /* check duyet khoa hoc khi co su dong ý cu nguoi dung
             * user_consent = UserAgrees
             * */
            if ($course_student->user_consent != StatusConstant::USERAGREES) {
                throw new BadRequestException(
                    ['message' => __("Không thể duyệt khoá học khi chưa có sự đồng ý từ phía người dùng !")],
                    new Exception()
                );
            }
            // update duyet dang ki
            $course_student->update(['status' => StatusConstant::SCHEDULE]);

            // gửi mail
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
            ['message' => __("Đăng kí không tồn tại !")],
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
                    ['message' => __("Gửi yêu cầu cho admin không thành công !")],
                    new Exception()
                );
            }

            // status phải  = Unschedule
            if ($course_student->status != StatusConstant::SCHEDULE) {
                throw new BadRequestException(
                    ['message' => __("Không thể gửi yêu cầu duyệt trong khi không ở trạng thái đang học !")],
                    new Exception()
                );
            }

            // check xem dang ki nay dã du so buoi hoc thanh cong ma o co khieu lai
            if (!($this->getCountScheduleComplete($id) == $this->getCountCoursePlanOff($course_id))) {
                throw new BadRequestException(
                    ['message' => __("Khoá học chưa kết thúc hoặc có thể khoá học đang có sự khiêu nại từ người dùng !")],
                    new Exception()
                );
            }
            // update course_student
            $course_student->update(['status' => StatusConstant::REQUESTADMIN]);

            return $course_student;
        }
        throw new BadRequestException(
            ['message' => __("Gửi yêu cầu cho admin không thành công !")],
            new Exception()
        );
    }



    // lấy za số lịch xếp cho những buổi học off của khoa hoc của customer
    /* xem lại -> dem schedule thông qua course_student_id -> where nó xong count
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
                ['message' => __("Không thể duyệt đăng ký này, hãy duyệt một cách tuần tự !")],
                new Exception()
            );
        }
    }

}
