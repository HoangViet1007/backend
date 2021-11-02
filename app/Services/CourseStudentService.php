<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Course;
use App\Models\CourseStudent;
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
        $data = $this->queryHelper->buildQuery($this->model)
                                  ->with(['users', 'courses'])
                                  ->join('users', 'users.id', 'course_students.user_id')
                                  ->join('courses', 'courses.id', 'course_students.course_id')
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
        if ($courseStudent->status == StatusConstant::PENDING) {
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
}
