<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Models\CoursePlanes;
use App\Models\CourseStudent;
use App\Models\Schedule;
use App\Models\Stage;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

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

    public function getScheduleByCourseStudent(object $request, $id)
    {
        $schedule = Schedule::where('course_student_id', $id)->get();

        return $schedule;
    }

    public function preAdd(object $request)
    {
        if (empty($request->course_student_id)) {
            throw new BadRequestException(
                ['message' => __("Không xác định được học viên để thêm lịch học !")], new Exception()
            );
        }
        $course_student_id = $request->course_student_id ?? null;
        $course_student    = CourseStudent::find($course_student_id);

        $course_student_service = new CourseStudentService();

        // validate
        /*  validate course_plan phai unique trong schedule cua course_student
         * */
        $arrayCoursePlanOff = $this->arrayCoursePlanOff($course_student->course_id);
        $this->doValidate($request,
                          [
                              'title'             => 'required|min:3',
                              'date'              => 'required|date',
                              'time_start'        => 'required',
                              'time_end'          => 'required',
                              // 'status'            => 'in:' . implode(',', $this->arrayStatusChedule),
                              'link_room'         => 'required',
                              'course_plan_id'    => [
                                  'required',
                                  Rule::unique('schedules',)->where(function ($query) use ($course_student_id) {
                                      return $query->where('course_student_id', '=', $course_student_id);
                                  }),
                                  'in:' . implode(',', $arrayCoursePlanOff),
                              ],
                              'course_student_id' => 'required'
                          ],
                          [
                              'title.required'             => 'Hãy nhập tiêu đề cho lịch học !',
                              'title.min'                  => 'Tiêu đề phải tối thiểu 3 kí tự !',
                              'date.required'              => 'Hãy nhập ngày tháng cho lịch học !',
                              'date.date'                  => 'Định dạng ngày tháng không hợp lệ !',
                              'time_start.required'        => 'Hãy nhập thời gian bắt đầu cho lịch học !',
                              'time_end.required'          => 'Hãy nhập thời gian kết thúc cho lịch học !',
                              // 'status.in'                  => 'Trạng thái lịch học không hợp lệ !',
                              'link_room.required'         => 'Hãy nhập đường dẫn trực tuyến cho lịch học !',
                              'course_plan_id.required'    => 'Hãy nhập buổi học !',
                              'course_plan_id.unique'      => 'Buổi học này đã được xếp lịch !',
                              'course_plan_id.in'          => 'Buổi học này không tồn tại !',
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
    }

    public function preUpdate(int|string $id, object $request)
    {
        /* check xem $id_schedule co phai cua user dang login hay ko
         * -> check id user dang login = created_by của khoá học mà lịch daỵ đó asign
         * */
        $user   = Auth::user();
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
        $course_student    = CourseStudent::find($course_student_id);

        $course_student_service = new CourseStudentService();

        // validate
        /*  validate course_plan phai unique trong schedule cua course_student
         * */
        $arrayCoursePlanOff = $this->arrayCoursePlanOff($course_student->course_id);
        $this->doValidate($request,
                          [
                              'title'             => 'required|min:3',
                              'date'              => 'required|date',
                              'time_start'        => 'required',
                              'time_end'          => 'required',
                              // 'status'            => 'in:' . implode(',', $this->arrayStatusChedule),
                              'link_room'         => 'required',
                              'course_plan_id'    => [
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
                              'title.required'             => 'Hãy nhập tiêu đề cho lịch học !',
                              'title.min'                  => 'Tiêu đề phải tối thiểu 3 kí tự !',
                              'date.required'              => 'Hãy nhập ngày tháng cho lịch học !',
                              'date.date'                  => 'Định dạng ngày tháng không hợp lệ !',
                              'time_start.required'        => 'Hãy nhập thời gian bắt đầu cho lịch học !',
                              'time_end.required'          => 'Hãy nhập thời gian kết thúc cho lịch học !',
                              // 'status.in'                  => 'Trạng thái lịch học không hợp lệ !',
                              'link_room.required'         => 'Hãy nhập đường dẫn trực tuyến cho lịch học !',
                              'course_plan_id.required'    => 'Hãy nhập buổi học !',
                              'course_plan_id.unique'      => 'Buổi học này đã được xếp lịch !',
                              'course_plan_id.in'          => 'Buổi học này không tồn tại !',
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
                                'time_start' => $request->date . ' ' . $request->time_start,
                                'time_end'   => $request->date . ' ' . $request->time_end,
                                'status'     => StatusConstant::UNFINISHED,
                            ]);
        } else {
            $request->time_start = $request->date . ' ' . $request->time_start;
            $request->time_end   = $request->date . ' ' . $request->time_end;
            $request->status     = StatusConstant::UNFINISHED;
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
        $date      = $this->convertDate($date);
        $data      = Schedule::where('date', '=', $date)
                             ->when($schedule_id, function ($q) use ($schedule_id) {
                                 // khi sua thi ko check gio cua ban ghi dang sua
                                 $q->where('id', '!=', $schedule_id);
                             })
                             ->get();
        if (count($data) > 0) {
            foreach ($data as $item) {
                $time_start = strtotime($item->time_start);
                $time_end   = strtotime($item->time_end);
                $time_check = strtotime($date . $timeCheck);

                if ($time_check >= $time_start && $time_check <= $time_end) {
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
        $stageId     = Stage::where('course_id', $course_id)->pluck('id')->toArray();
        $course_plan = CoursePlanes::whereIn('stage_id', $stageId)->where('type', 0)
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

    public function preDelete(int|string $id)
    {
        /* check schedule nay cos phai cua user dang login hay ko
         * khi schedule cos status = unfinished moi dc xoa || kho hoc nay dax ket thuc (status course_sudent = complete)
         * */
        $user   = Auth::user();
        $userId = $user['id'];
        if (!($userId == $this->checkScheduleCurrentUser($id))) {
            throw new BadRequestException(
                ['message' => __("Lịch học không tồn tại !")],
                new Exception()
            );
        }

        $schedule       = Schedule::find($id);
        $course_student = CourseStudent::find($schedule->course_student_id);
        if (!($schedule->status == StatusConstant::UNFINISHED || $course_student->status == StatusConstant::COMPLETE)) {
            throw new BadRequestException(
                ['message' => __("Xoá lịch học không thành công !")],
                new Exception()
            );
        }
    }
}
