<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Mail\Schedule\AcceptComlaintCustorm;
use App\Mail\Schedule\AcceptComlaintPT;
use App\Mail\Schedule\ScheduleCourseCustorm;
use App\Mail\Schedule\ScheduleDontComplainCustorm;
use App\Mail\Schedule\ScheduleDontComplainPT;
use App\Mail\CancelCourse;
use App\Mail\Schedule\SendLinkRecordCustorm;
use App\Mail\Schedule\SendLinkRecordPT;
use App\Mail\ScheduleCourse;
use App\Models\Course;
use App\Models\CoursePlanes;
use App\Models\CourseStudent;
use App\Models\Schedule;
use App\Models\Stage;
use Carbon\CarbonPeriod;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Illuminate\Validation\Rule;
use Illuminate\Database\Eloquent\Builder;

/**
 * @Author apple
 * @Date   Nov 03, 2021
 */
class ScheduleService extends BaseService
{
    public $arrayStatusChedule = [StatusConstant::UNFINISHED, StatusConstant::COMPLETE];

    function createModel(): void
    {
        $this->model = new Schedule();
    }

    public function getScheduleByCourseStudent(object $request, $id, $user_id = null)
    {
        if ($user_id) {
            $userLogin = Auth::user();
            if (!($user_id == $userLogin['id'])) {
                throw new BadRequestException(
                    ['message' => __("Lịch học không tồn tại !")], new Exception()
                );
            }
        }
        $data = $this->queryHelper->buildQuery($this->model)
            ->with(['course_student.users', 'course_student.courses.teacher', 'course_planes.stage'])
            ->when($user_id, function ($q) use ($user_id) {
                $q->join('course_students', 'schedules.course_student_id', 'course_students.id')
                    ->where('course_students.user_id', $user_id);
            })
            ->select('schedules.*')
            ->where('course_student_id', $id);
        try {
            $response = $data->get();
            $this->postGetAll($response);

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // get calender work
    public function getCalenderCustomer(object $request)
    {
        try {
            $date = $request->date ?? null;
            $user = Auth::user();
            $arrayCourseStudentId = CourseStudent::where('user_id', $user['id'])
                ->where('status', StatusConstant::SCHEDULE)
                ->pluck('id')->toArray();
            $schedule = Schedule::whereIn('course_student_id', $arrayCourseStudentId)
                ->when($date, function ($q) use ($date) {
                    $q->where('date', $date);
                })
                ->with(['course_student.courses.teacher', 'course_planes.stage'])
                ->get();

            return $schedule;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getCalenderPt(object $request)
    {
        $date = $request->date ?? null;
        $user = Auth::user();
        try {
            $schedule = Schedule::with(['course_student.courses', 'course_student.users', 'course_planes.stage'])
                ->leftJoin('course_students', 'schedules.course_student_id', 'course_students.id')
                ->leftJoin('courses', 'course_students.course_id', 'courses.id')
                ->when($date, function ($q) use ($date) {
                    $q->where('schedules.date', $date);
                })
                ->where('course_students.status', StatusConstant::SCHEDULE)
                ->where('courses.created_by', $user['id'])
                ->select('schedules.*')
                ->get();

            return $schedule;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function preAdd(object $request)
    {
        if (empty($request->course_student_id)) {
            throw new BadRequestException(
                ['message' => __("Không xác định được học viên để thêm lịch học !")], new Exception()
            );
        }
        $course_student_id = $request->course_student_id ?? null;
        $course_student = CourseStudent::find($course_student_id);

        $course_student_service = new CourseStudentService();

        // validate
        /*  validate course_plan phai unique trong schedule cua course_student
         * */
        $arrayCoursePlanOff = $this->arrayCoursePlanOff($course_student->course_id);

        $this->doValidate($request,
            [
                'title' => 'required|min:3',
                'date' => 'required|date|after:yesterday',
                'time_start' => 'required',
                'time_end' => 'required|after:time_start',
                'link_room' => 'required',
                'course_plan_id' => [
                    'required',
                    Rule::unique('schedules',)->where(function ($query) use ($course_student_id) {
                        return $query->where('course_student_id', '=', $course_student_id);
                    }),
                    'in:' . implode(',', $arrayCoursePlanOff),
                ],
                'course_student_id' => 'required'
            ],
            [
                'title.required' => 'Hãy nhập tiêu đề cho lịch học !',
                'title.min' => 'Tiêu đề phải tối thiểu 3 kí tự !',
                'date.required' => 'Hãy nhập ngày tháng cho lịch học !',
                'date.date' => 'Định dạng ngày tháng không hợp lệ !',
                'date.after' => 'Ngày tháng không hợp lệ !',
                'time_start.required' => 'Hãy nhập thời gian bắt đầu cho lịch học !',
                'time_end.after' => 'Thời gian không hợp lệ !',
                'time_end.required' => 'Hãy nhập thời gian kết thúc cho lịch học !',
                'link_room.required' => 'Hãy nhập đường dẫn trực tuyến cho lịch học !',
                'course_plan_id.required' => 'Hãy nhập buổi học !',
                'course_plan_id.unique' => 'Buổi học này đã được xếp lịch !',
                'course_plan_id.in' => 'Buổi học này không tồn tại !',
                'course_student_id.required' => 'Hãy nhập học viên tham gia lịch học !'
            ]
        );

        // check
        if ($this->checkDateIsNotInRange($request->date, $request->time_start) == false ||
            $this->checkDateIsNotInRange($request->date, $request->time_end) == false) {
            throw new BadRequestException(
                ['message' => __("Giờ học này đã bị trùng, vui lòng chọn giờ học khác !")], new Exception()
            );
        }
        // dem xem da them lich qua so buoi hoc off chua thif check sôa buổi off của > só schedule của customer
        /* truyền lên count_student -> course_id -> đếm số buổi học off
         *  lấy za số schedule của customer :
         * + dua vao count_student_id -> lấy za số lịch của customer
         * ---> so sanh
         * */
        if (isset($course_student)) {
            if (!($course_student_service->getCountScheduleForCourseStudent($course_student_id) < $course_student_service->getCountCoursePlanOff($course_student->course_id))) {
                throw new BadRequestException(
                    ['message' => __("Thêm lịch học không thành công, lịch học đã đủ cho tất cả các buổi học trực tuyến !")],
                    new Exception()
                );
            }
        }

        // handle request
        if ($request instanceof Request) {
            $request->merge([
                'status' => StatusConstant::UNFINISHED,
            ]);
        } else {
            $request->status = StatusConstant::UNFINISHED;
        }
    }

    // schedule repeat
    public function scheduleRepeat(object $request)
    {
        // array course_planes_off
        $coursePlanesOff = $this->getCoursePlanOffInScheduleService($request->course_student_id);
        // array day and hour request
        $dayAndHour = $request->day_and_hourse;
        // today and add day
        $today = date('y-m-d');
        $dayCong = Carbon::now()->addDays(1);

        // for
        $period = CarbonPeriod::create($today, $dayCong);
        while (count($coursePlanesOff) > 0) {
            foreach ($period as $item) {
                if ($item == "2021-11-27") {
                    $dayCong->addDay(1);
                    continue;
                }
                // insert
                dd(1);
            }

            $length = count($coursePlanesOff) - 1;
            unset($coursePlanesOff[$length]);
        }

        return true;
    }


    public function getCoursePlanOffInScheduleService($course_student_id)
    {
        $courseStudent = CourseStudent::find($course_student_id);
        $course = Course::findOrFail($courseStudent->course_id);

        // lay buoi off da xep lich
        $coursePlanScheduled = Schedule::where('course_student_id', $course_student_id)->pluck('course_plan_id')
            ->toArray();

        if ($course && $course->status == StatusConstant::HAPPENING && $course->display == StatusConstant::ACTIVE)
            $entity = Course::join('stages', 'courses.id', 'stages.course_id')
                ->join('course_planes', 'stages.id', 'course_planes.stage_id')
                ->where('stages.status', StatusConstant::ACTIVE)
                ->where('course_planes.status', StatusConstant::ACTIVE)
                ->where('course_planes.type', 0)
                ->where('courses.id', $courseStudent->course_id)
                ->when($coursePlanScheduled, function ($q) use ($coursePlanScheduled) {
                    $q->whereNotIn('course_planes.id', $coursePlanScheduled);
                })
                ->select('course_planes.*')
                ->pluck('course_planes.id')->toArray();

        return $entity;
    }

    public function preUpdate(int|string $id, object $request)
    {
        /* check xem $id_schedule co phai cua user dang login hay ko
         * -> check id user dang login = created_by của khoá học mà lịch daỵ đó asign
         * */
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentUser($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }

        if (empty($request->course_student_id)) {
            throw new BadRequestException(
                ['message' => __("Không xác định được học viên để thêm lịch học !")], new Exception()
            );
        }

        $course_student_id = $request->course_student_id ?? null;
        $course_student = CourseStudent::find($course_student_id);

        $course_student_service = new CourseStudentService();

        // validate
        /*  validate course_plan phai unique trong schedule cua course_student
         * */
        $arrayCoursePlanOff = $this->arrayCoursePlanOff($course_student->course_id);
        $this->doValidate($request,
            [
                'title' => 'required|min:3',
                'date' => 'required|date|after:yesterday',
                'time_start' => 'required',
                'time_end' => 'required|after:time_start',
                'link_room' => 'required',
                'course_plan_id' => [
                    'required',
                    Rule::unique('schedules',)->where(function ($query) use ($course_student_id, $id) {
                        return $query->where('course_student_id', '=', $course_student_id)
                            ->where('id', '!=', $id);
                    }),
                    'in:' . implode(',', $arrayCoursePlanOff),
                ],
                'course_student_id' => 'required'
            ],
            [
                'title.required' => 'Hãy nhập tiêu đề cho lịch học !',
                'title.min' => 'Tiêu đề phải tối thiểu 3 kí tự !',
                'date.required' => 'Hãy nhập ngày tháng cho lịch học !',
                'date.date' => 'Định dạng ngày tháng không hợp lệ !',
                'date.after' => 'Ngày tháng không hợp lệ !',
                'time_start.required' => 'Hãy nhập thời gian bắt đầu cho lịch học !',
                'time_end.after' => 'Thời gian không hợp lệ !',
                'time_end.required' => 'Hãy nhập thời gian kết thúc cho lịch học !',
                'link_room.required' => 'Hãy nhập đường dẫn trực tuyến cho lịch học !',
                'course_plan_id.required' => 'Hãy nhập buổi học !',
                'course_plan_id.unique' => 'Buổi học này đã được xếp lịch !',
                'course_plan_id.in' => 'Buổi học này không tồn tại !',
                'course_student_id.required' => 'Hãy nhập học viên tham gia lịch học !'
            ]
        );

        // check
        if ($this->checkDateIsNotInRange($request->date, $request->time_start, $id) == false ||
            $this->checkDateIsNotInRange($request->date, $request->time_end, $id) == false) {
            throw new BadRequestException(
                ['message' => __("Giờ học này đã bị trùng, vui lòng chọn giờ học khác !")], new Exception()
            );
        }

        // handle request
        if ($request instanceof Request) {
            $request->merge([
                'status' => StatusConstant::UNFINISHED,
            ]);
        } else {
            $request->status = StatusConstant::UNFINISHED;
        }
    }

    public function checkDateIsNotInRange($date, $timeCheck = null, $schedule_id = null)
    {
        // convert date va hours
        /* lấy za lịch học của ngày mà người dùng truyền vào
         * lặp qua từng phần tử ->time = [time_start,time_end] của bản pt đó
         * check time_start || time_end người dùng truyền vào có nằm trong khoảng time ko
         * */
        $timeCheck = date('H:i:s', strtotime($timeCheck));
        $date = $this->convertDate($date);
        $data = Schedule::where('date', '=', $date)
            ->when($schedule_id, function ($q) use ($schedule_id) {
                // khi sua thi ko check gio cua ban ghi dang sua
                $q->where('id', '!=', $schedule_id);
            })
            ->get();
        if (count($data) > 0) {
            foreach ($data as $item) {
                $time_start = strtotime($item->date . ' ' . $item->time_start);
                $time_end = strtotime($item->date . ' ' . $item->time_end);
                $time_check = strtotime($date . $timeCheck);

                if (($time_check >= $time_start && $time_check <= $time_end && $item->status == StatusConstant::UNFINISHED)) {
                    return false;
                } else {
                    return true;
                }
            }
        } else {
            return true;
        }
    }

    public function convertDate($date)
    {
        $timestamp = strtotime($date);
        // Creating new date format from that timestamp
        $new_date = date("Y-m-d", $timestamp);

        return $new_date;
    }

    public function getHours($time)
    {
        $arrayItem = explode(' ', $time);

        return $arrayItem[1];
    }

    public function arrayCoursePlanOff($course_id)
    {
        $stageId = Stage::where('course_id', $course_id)->pluck('id')->toArray();
        $course_plan = CoursePlanes::whereIn('stage_id', $stageId)
            ->where('type', 0)
            ->where('status', StatusConstant::ACTIVE)->pluck('id')->toArray();

        return $course_plan;
    }

    public function checkScheduleCurrentUser($schedule)
    {
        $scheduleData = Schedule::find($schedule);
        if ($scheduleData) {
            $data = Schedule::join('course_students', 'schedules.course_student_id', 'course_students.id')
                ->join('courses', 'course_students.course_id', 'courses.id')
                ->where('schedules.id', $schedule)
                ->first();

            return $data->created_by;
        }
    }

    // check xem có phải khóa học của customer không
    public function checkScheduleCurrentCustomer($schedule)
    {
        $scheduleData = Schedule::find($schedule);
        if ($scheduleData) {
            $data = Schedule::join('course_students', 'schedules.course_student_id', 'course_students.id')
                ->where('schedules.id', $schedule)
                ->first();
            return $data->user_id;
        }
    }

    public function preDelete(int|string $id)
    {
        /* check schedule nay cos phai cua user dang login hay ko
         * khi schedule cos status = unfinished moi dc xoa || kho hoc nay dax ket thuc (status course_sudent = complete)
         * */
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentCustomer($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }

        $schedule = Schedule::find($id);
        $course_student = CourseStudent::find($schedule->course_student_id);
        if (!($schedule->status == StatusConstant::UNFINISHED || $course_student->status == StatusConstant::COMPLETE || $course_student->status == StatusConstant::UNSCHEDULED)) {
            throw new BadRequestException(
                ['message' => __("Xoá lịch học không thành công !")],
                new Exception()
            );
        }

    }

    // update status schedule complete
    public function updateStatusScheduleComplete($id, object $request)
    {
        /* check xem schedule co phai cua user dang login hay ko
         * */
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentCustomer($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }
        // gui email thong bao cho nguoi dung da hoc xong

        dd($id);
        $schedule = Schedule::find($id);
        $schedule->update(['status' => StatusConstant::COMPLETE]);
    }


    public function listComplain()
    {
        $this->preGetAll();
        $data = Schedule::where('complain', StatusConstant::COMPLAIN)->with(['course_student.users', 'course_planes.stage.course.teacher']);

        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);

            $response->map(function ($item) {

                $item['name_student'] = isset($item->course_student->users->name) ? $item->course_student->users->name : '';
                $item['name_stage'] = isset($item->course_planes->stage->name) ? $item->course_planes->stage->name : '';
                $item['name_course'] = isset($item->course_planes->stage->course->name) ? $item->course_planes->stage->course->name : '';

                return $item;

            });

            return $response;

        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }


    public function changeComplain($request)
    {

        $data = Schedule::find($request['schedule_id']);

        // info PT
        if ($data) {

            $dataCourse = CoursePlanes::where('id', $data['course_plan_id'])->with(['stage'])->first();

            $dataPt = Stage::where('id', $dataCourse->stage->id)->with('course')->first();
            // tên giai đoạn
            $name_cousre_plane = $data->title;

            $id_pt = $dataPt->course->created_by;

            $info_pt = User::where('id', $id_pt)->first();

            $name_pt = $info_pt->name;
            $email_pt = $info_pt->email;
            $date_complain = $data->date;

            // info Student

            $dataCustorm = CourseStudent::where('id', $data['course_student_id'])->with(['users'])->first();

            $email_custorm = $dataCustorm->users->email;
            $name_custorm = $dataCustorm->users->name;

            if (!empty($request['complain']) && $data) {

                switch ($request['complain']) {
                    // complain dont success
                    case 'nocomplain' :

                        // send email pt
                        Mail::to('ngohongnguyen016774@gmail.com')->send(new ScheduleDontComplainPT($name_cousre_plane, $name_pt, $date_complain));
                        // send email custorm
                        Mail::to('ngohongnguyen016774@gmail.com')->send(new ScheduleDontComplainCustorm($name_custorm, $name_cousre_plane, $name_pt, $date_complain));
                        if (Mail::failures()) {
                            throw new BadRequestException(
                                ['message' => __("Gửi email không thành công !")],
                                new Exception()
                            );
                        } else {
                            $data->update(['complain' => StatusConstant::NOCOMPLAINTS,
                                'reason_complain'=>null,
                             ]);

                            return true;
                        }


                    case 'complain' :

                        // send email pt accept complaints

                        Mail::to($email_pt)->send(new AcceptComlaintPT($name_cousre_plane, $name_pt, $date_complain));
                        // send email custorm
                        Mail::to($email_custorm)->send(new AcceptComlaintCustorm($name_custorm, $name_cousre_plane, $name_pt, $date_complain));


                        if (Mail::failures()) {
                            throw new BadRequestException(
                                ['message' => __("Gửi email không thành công !")],
                                new Exception()
                            );
                        } else {
                            $data->update(['status' => StatusConstant::UNFINISHED,
                                'complain' => StatusConstant::NOCOMPLAINTS,
                                'link_record'=>null,
                                'check_link_record' => null,
                                'date_send_link_record' => null,
                                'reason_complain'=>null]);
                            return true;

                        }

                    case 'send_link_record' :

                        Mail::to('ngohongnguyen016774@gmail.com')
                            ->send(new SendLinkRecordPT($name_custorm, $name_cousre_plane, $name_pt, $date_complain,$data['reason_complain']));

                        if (Mail::failures()) {
                            throw new BadRequestException(
                                ['message' => __("Gửi email không thành công !")],
                                new Exception()
                            );
                        } else {

                            $data->update(['check_link_record' => StatusConstant::SENTSUCCESS,
                                'date_send_link_record' => Carbon::now()->addDay()]);
                            return true;
                        }

                    default :
                        break;
                }
            }
        } else {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }

    }

    // từ chối tham gia buổi học
    public function notEngaged($id, object $request)
    {
        /* check xem schedule co phai cua user dang login hay ko
         * */
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentCustomer($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }
        // gui email cho pt thông báo người dùng không tham gia buổi học.

        $schedule = Schedule::find($id);
        $schedule->update([
            'participation' => StatusConstant::NOJOIN,
            'status' => StatusConstant::COMPLETE
        ]);

        return $schedule;
    }

    // chấp nhận tham gia buổi học
    public function engaged($id, object $request)
    {
        /* check xem schedule co phai cua user dang login hay ko
         * */
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentCustomer($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }

        $schedule = Schedule::find($id);
        $schedule->update([
            'participation' => StatusConstant::JOIN
        ]);

        return $schedule;
    }

    // customer khiếu nại
    public function complanin($id, object $request)
    {
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentCustomer($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }

        $schedule = Schedule::find($id);
        if ($schedule->status != StatusConstant::COMPLETE) {
            throw new BadRequestException(
                ['message' => __("Buổi học chưa kết thúc, quý khách vui lòng đợi thêm !")],
                new Exception()
            );
        }
        if (!$request->reason_complain || $request->reason_complain == "") {
            throw new BadRequestException(
                ['message' => __("Vui lòng nhập lý do bạn khiếu nại buổi học !")],
                new Exception()
            );
        }
    }

    // customer hủy khiếu nại
    public function cancelComplain($id)
    {
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentCustomer($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }

        $schedule = Schedule::find($id);
        if ($schedule->complain != StatusConstant::COMPLAIN) {
            throw new BadRequestException(
                ['message' => __("Buổi học này không bị khiếu nại !")],
                new Exception()
            );
        }

        // gửi mail cho pt thông báo bị khiếu nại ở đây

        $schedule->update([
            'complain' => StatusConstant::COMPLAIN,
            'reason_complain' => $request->reason_complain
        ]);

        return $schedule;
    }

    public function getComplainForCustomer()
    {
        $this->preGetAll();
        $courseStudent = CourseStudent::where('user_id', Auth::id())->first();
        $data = Schedule::where(['complain' => StatusConstant::COMPLAIN, 'course_student_id' => $courseStudent->id])->with(['course_student.users', 'course_planes.stage.course.teacher']);

        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);
            return $response;

        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // bắt dầu buổi học
    public function startSchedule($id, object $request)
    {
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentUser($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }

        $schedule = Schedule::find($id);
        if ($schedule->participation != StatusConstant::JOIN) {
            throw new BadRequestException(
                ['message' => __("Học viên chưa xác nhận tham gia !")],
                new Exception()
            );
        }

        $schedule->update([
            'status' => StatusConstant::HAPPENNING,
            'actual_start_time' => date('Y-m-d H:i:s')
        ]);
        return $schedule;

    }

    // check nếu không tham gia thì hiện chữ: Đã hoàn thành

    // kết thúc buổi học -> hiện thị button upload record
    // nếu có link record hiện thị button sửa record
    public function endSchedule($id, object $request)
    {
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentUser($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }
        $linkRecord = $request->link_record ?? null;
        $schedule = Schedule::find($id);
        $schedule->update([
            'status' => StatusConstant::COMPLETE,
            'link_record' => $linkRecord,
            'actual_end_time' => date('Y-m-d H:i:s')
        ]);
        return $schedule;
    }

    // upload link record
    public function updateRecord($id, object $request)
    {
        $user = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentUser($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }
        $schedule = Schedule::find($id);
        if ($schedule->status != StatusConstant::COMPLETE) {
            throw new BadRequestException(
                ['message' => __("Buổi học chưa kết thúc !")],
                new Exception()
            );
        }
        if (!$request->link_record || $request->link_record == "") {
            throw new BadRequestException(
                ['message' => __("Vui lòng nhập link record buổi học !")],
                new Exception()
            );
        }
        $schedule->update([
            'link_record' => $request->link_record
        ]);
        return $schedule;
    }

    public function schedulePT()
    {

        $date = Carbon::now();

        $schedule = Schedule::with(['course_student.courses', 'course_student.users', 'course_planes.stage.course.teacher'])
            ->leftJoin('course_students', 'schedules.course_student_id', 'course_students.id')
            ->leftJoin('courses', 'course_students.course_id', 'courses.id')
            ->when($date, function ($q) use ($date) {
                $q->where('schedules.date', $date);
            })
            ->where('schedules.status', StatusConstant::UNFINISHED)
            ->where('course_students.status', StatusConstant::SCHEDULE)
            ->select('schedules.*')
            ->get();
        $arrInfoTeacher = [];
        foreach ($schedule as $key => $value) {
            $data_key = $value->course_planes->stage->course->teacher->id;

            if (array_key_exists($data_key, $arrInfoTeacher)) {
                $data_childer = [
                    'link_room' => $value->link_room,
                    'time_start' => $value->time_start,
                    'time_end' => $value->time_end,
                    'title' => $value->title,
                    'name_student' => $value->course_student->users->name,
                    'email_student' => $value->course_student->users->email,
                    'phone_student' => $value->course_student->users->phone,
                    'name_course_plane' => $value->course_planes->name,
                    'name_stage' => $value->course_planes->stage->name,
                    'name_course' => $value->course_planes->stage->course->name,
                ];
                array_push($arrInfoTeacher[$data_key]['info_course'], $data_childer);
            } else {
                $data = [];
                $data_childer = array();
                $data['id'] = $value->course_planes->stage->course->teacher->id;
                $data['name_teacher'] = $value->course_planes->stage->course->teacher->name;
                $data['email'] = $value->course_planes->stage->course->teacher->email;


                $data_childer[] = [
                    'link_room' => $value->link_room,
                    'time_start' => $value->time_start,
                    'time_end' => $value->time_end,
                    'title' => $value->title,
                    'name_student' => $value->course_student->users->name,
                    'email_student' => $value->course_student->users->email,
                    'phone_student' => $value->course_student->users->phone,
                    'name_course_plane' => $value->course_planes->name,
                    'name_stage' => $value->course_planes->stage->name,
                    'name_course' => $value->course_planes->stage->course->name,
                ];

                $data['info_course'] = $data_childer;
                $arrInfoTeacher[$data_key] = $data;
            }
            foreach ($arrInfoTeacher as $value) {
                Mail::to('ngohongnguyen016774@gmail,com')->send(new ScheduleCourse($value['name_teacher'], $value['info_course'], $date));
            }
        }
    }


    public function scheduleCustorm()
    {
        $date = Carbon::now();

        $schedule = Schedule::with(['course_student.courses', 'course_student.users', 'course_planes.stage.course.teacher'])
            ->leftJoin('course_students', 'schedules.course_student_id', 'course_students.id')
            ->leftJoin('courses', 'course_students.course_id', 'courses.id')
            ->where('date', '2021-12-18')
            ->where('course_students.status', StatusConstant::SCHEDULE)
            ->select('schedules.*')
            ->get();
        $arrInfoStudent = [];
        foreach ($schedule as $key => $value) {
            $data_key = $value->course_student->users->id;

            if (array_key_exists($data_key, $arrInfoStudent)) {
                $data_childer = [
                    'link_room' => $value->link_room,
                    'time_start' => $value->time_start,
                    'time_end' => $value->time_end,
                    'title' => $value->title,
                    'name_teacher' => $value->course_planes->stage->course->teacher->name,
                    'email_teacher' => $value->course_planes->stage->course->teacher->email,
                    'phone_teacher' => $value->course_planes->stage->course->teacher->phone,
                    'name_course_plane' => $value->course_planes->name,
                    'name_stage' => $value->course_planes->stage->name,
                    'name_course' => $value->course_planes->stage->course->name,
                ];
                array_push($arrInfoStudent[$data_key]['info_course'], $data_childer);
            } else {
                $data = [];
                $data_childer = array();
                $data['id'] = $value->course_student->users->id;
                $data['name_student'] = $value->course_student->users->name;
                $data['email'] = $value->course_student->users->email;

                $data_childer[] = [
                    'link_room' => $value->link_room,
                    'time_start' => $value->time_start,
                    'time_end' => $value->time_end,
                    'title' => $value->title,
                    'name_teacher' => $value->course_planes->stage->course->teacher->name,
                    'email_teacher' => $value->course_planes->stage->course->teacher->email,
                    'phone_teacher' => $value->course_planes->stage->course->teacher->phone,
                    'name_course_plane' => $value->course_planes->name,
                    'name_stage' => $value->course_planes->stage->name,
                    'name_course' => $value->course_planes->stage->course->name,
                ];

                $data['info_course'] = $data_childer;
                $arrInfoStudent[$data_key] = $data;
            }

            foreach ($arrInfoStudent as $value) {
                Mail::to('ngohongnguyen016774@gmail.com')->send(new ScheduleCourseCustorm($value['name_student'], $value['info_course'], $date));
            }
        }
    }

    public function updateLevel()
    {

        $info_teacher = CourseStudent::with('courses')->get();
        $array_id_teacher = $info_teacher->pluck('courses.created_by')->unique();

        foreach ($array_id_teacher as $value) {
            $count_student = CourseStudent::with(['courses' => function ($qr) use ($value) {
                return $qr->where('created_by', $value);
            }])->where('status', StatusConstant::COMPLETE)->count();
            $count_level_pt = User::find($value);
            if ($count_student <= 7 || $count_student > 5) {
                $count_level_pt->update(['account_level_id' => 2]);
            } elseif ($count_student <= 9 || $count_student > 7) {
                $count_level_pt->update(['account_level_id' => 3]);
            } elseif ($count_student <= 12 || $count_student > 9) {
                $count_level_pt->update(['account_level_id' => 4]);
            } elseif ($count_student > 12) {
                $count_level_pt->update(['account_level_id' => 5]);
            }
        }
    }

    // CRON JOB update course success

    public function updateCourseSucces()
    {

        $list_course = Schedule::where('status', StatusConstant::UNFINISHED)->get();

        foreach ($list_course as $value) {
            $dueDateTime = Carbon::createFromFormat('Y-m-d H:i:s', $value->date . ' ' . $value->time_start)->addDay(2);
            $date_now = \Carbon\Carbon::now();
            if ($dueDateTime >= $date_now) {
                $update = Schedule::find($value->id);
                $update->update(['status' => StatusConstant::COMPLETE, 'participation' => StatusConstant::NOJOIN]);
            }
        }
    }
}
