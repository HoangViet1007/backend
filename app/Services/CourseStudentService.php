<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Course;
use App\Models\CoursePlanes;
use App\Models\CourseStudent;
use App\Models\Schedule;
use App\Models\Stage;
use App\Models\User;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;

/**
 * @Author apple
 * @Date   Oct 31, 2021
 */
class CourseStudentService extends BaseService
{

    function createModel(): void
    {
        $this->model = new CourseStudent();
    }

    public function getAll(): LengthAwarePaginator
    {
        $userIdLogin = Auth::user();
        $data        = $this->queryHelper->buildQuery($this->model)
                                         ->with(['users', 'courses'])
                                         ->join('users', 'users.id', 'course_students.user_id')
                                         ->join('courses', 'courses.id', 'course_students.course_id')
                                         ->where('courses.created_by', '=', $userIdLogin['id'])
                                         ->select('course_students.*');
        try {
            $response = $data->paginate(QueryHelper::limit());

            return $response;
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
            // hoan lai tien 90% kho hoc
            $courseId     = $courseStudent->course_id;
            $course       = Course::find($courseId);
            $price_course = (int)$course->price * 0.9;
            $user         = User::find($courseStudent->user_id)->update(['money' => $price_course]);

            // gửi email cho người dùng

            return CourseStudent::find($id);
        } else {
            throw new BadRequestException(
                ['message' => __("Bạn không thể huỷ khoá học !")], new Exception()
            );
        }
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

            // hoan lai tien 90% kho hoc
            $courseId     = $courseStudent->course_id;
            $course       = Course::find($courseId);
            $price_course = (int)$course->price;
            $user         = User::find($courseStudent->user_id)->update(['money' => $price_course]);

            // gửi email cho người dùng

            return CourseStudent::find($id);
        } else {
            throw new BadRequestException(
                ['message' => __("Bạn không thể huỷ khoá học !")], new Exception()
            );
        }
    }

    public function getCourseForCustomer($id)
    {
        $user_id = Auth::user();
        try {
            if ($id == $user_id['id']) {
                $data     = $this->queryHelper->buildQuery($this->model)
                                              ->with(['users', 'courses'])
                                              ->join('users', 'users.id', 'course_students.user_id')
                                              ->join('courses', 'courses.id', 'course_students.course_id')
                                              ->select('course_students.*')
                                              ->where('user_id', $id);
                $response = $data->paginate(QueryHelper::limit());

                return $response;
            }
        } catch (Exception $exception) {
            throw new BadRequestException(
                ['message' => __("Không tồn tại khoá học !")], new Exception()
            );
        }
    }

    // duyet dang ki
    public function ptThough(object $request, $id)
    {
        $course_student = CourseStudent::find($id);
        $user_id        = $course_student->user_id;
        $course_id      = $course_student->course_id;


        // status phải  = Unschedule
        if (!($course_student->status == StatusConstant::UNSCHEDULED)) {
            throw new BadRequestException(
                ['message' => __("Không thể duyệt khoá học trong khi đang không ở trạng thái chờ lên lịch !")],
                new Exception()
            );
        }

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

        // update duyet dang ki
        $course_student->update(['status' => StatusConstant::SCHEDULE]);

        return true;
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

    public function getCountCoursePlanOff($course_id)
    {
        $stageId     = Stage::where('course_id', $course_id)->pluck('id')->toArray();
        $course_plan = CoursePlanes::whereIn('stage_id', $stageId)->where('type', 0)->count();

        return $course_plan;
    }

}
