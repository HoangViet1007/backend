<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\NotFoundException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Course;
use App\Models\CoursePlanes;
use App\Models\CourseStudent;
use App\Models\SpecializeDetail;
use App\Models\Stage;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

/**
 * @Author apple
 * @Date   Oct 06, 2021
 */
class CourseService extends BaseService
{
    protected array $status  = [StatusConstant::HAPPENING, StatusConstant::PENDING, StatusConstant::PAUSE, StatusConstant::REQUEST];
    protected array $display = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];


    function createModel(): void
    {
        $this->model = new Course();
    }

    // get all course for pt no paginate
    public function getAllCourseCurrentPtNoPaginate()
    {
        return Course::all();
    }

    // hàm này cho admin
    public function getAll(): LengthAwarePaginator
    {
        $this->preGetAll();
        $data = $this->queryHelper->buildQuery($this->model)->with('customerLevel', 'stages', 'specializeDetails.user',
                                                                   'specializeDetails.specialize')
                                  ->join('specialize_details', 'courses.specialize_detail_id',
                                         'specialize_details.id')
                                  ->join('specializes', 'specialize_details.specialize_id',
                                         'specializes.id')
                                  ->join('customer_levels', 'courses.customer_level_id',
                                         'customer_levels.id')
                                  ->join('users', 'specialize_details.user_id', 'users.id')
                                  ->select('courses.*');
        try {
            $response = $data->paginate(QueryHelper::limit());

            $response->getCollection()->transform(function ($value) {
                $value->total_stages = count($value->stages);
                unset($value->stages);

                return $value;
            });

            $this->postGetAll($response);

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // get course cua pt
    public function getCourseCurrentPt()
    {
        $request = request()->all();
        $data    = $this->queryHelper->buildQuery($this->model)
                                     ->with('customerLevel', 'stages', 'specializeDetails.user',
                                            'specializeDetails.specialize')
                                     ->join('specialize_details', 'courses.specialize_detail_id',
                                            'specialize_details.id')
                                     ->join('specializes', 'specialize_details.specialize_id',
                                            'specializes.id')
                                     ->join('customer_levels', 'courses.customer_level_id',
                                            'customer_levels.id')
                                     ->join('users', 'specialize_details.user_id', 'users.id')
                                     ->select('courses.*')
                                     ->where('users.id', self::currentUser()->id);
        try {
            $response = $data->get();

            // $response->getCollection()->transform(function ($value) {
            //     $value->total_stages = count($value->stages);
            //     unset($value->stages);
            //
            //     return $value;
            // });

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // get courses in client
    public function getCourse()
    {
        $this->preGetAll();
        $statusActive    = StatusConstant::ACTIVE;
        $statusHappening = StatusConstant::HAPPENING;
        $request         = request()->all();
        $specializes     = $request['specializes'] ?? null;
        $level           = $request['level'] ?? null;

        $data = $this->queryHelper->removeParam('level')
                                  ->removeParam('specializes')
                                  ->buildQuery($this->model)
                                  ->with(['customerLevel', 'specializeDetails.user',
                                          'specializeDetails.specialize'])
                                  ->leftJoin('specialize_details', 'courses.specialize_detail_id',
                                             'specialize_details.id')
                                  ->leftJoin('specializes', 'specialize_details.specialize_id',
                                             'specializes.id')
                                  ->leftJoin('customer_levels', 'courses.customer_level_id',
                                             'customer_levels.id')
                                  ->leftJoin('users', 'specialize_details.user_id', 'users.id')
                                  ->select('courses.*')
                                  ->when($specializes, function ($q) use ($specializes) {
                                      $arraySpecialize = explode(',', $specializes) ?? [0];
                                      $q->whereIn('specializes.id', $arraySpecialize);
                                  })
                                  ->when($level, function ($q) use ($level) {
                                      $arrayLevel = explode(',', $level) ?? [0];
                                      $q->whereIn('customer_levels.id', $arrayLevel);
                                  })
                                  ->where(function ($query) use ($statusActive, $statusHappening) {
                                      $query->where('courses.display', $statusActive)
                                            ->where('courses.status', $statusHappening);
                                  });
        try {
            $response = $data->paginate(QueryHelper::limit());

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // get course detail in client by id
    public function getCourseByIdInClient($id)
    {
        try {
            $course = Course::findOrFail($id);
            if ($course && $course->status == StatusConstant::HAPPENING && $course->display == StatusConstant::ACTIVE)
                $entity = $this->queryHelper->buildQuery($this->model)
                                            ->with(['customerLevel', 'specializeDetails.user',
                                                    'specializeDetails.specialize'])
                                            ->with(['stagesClient.course_planes' => function ($q) {
                                                $q->where('course_planes.status', StatusConstant::ACTIVE);
                                            }])
                                            ->select('courses.*')
                                            ->where('courses.id', $id)
                                            ->first();

            return $entity;
        } catch (ModelNotFoundException $e) {
            throw new NotFoundException(
                ['message' => __("not-exist", ['attribute' => __('entity')]) . ": $id"],
                $e
            );
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getCourseCurrentPtById($id)
    {
        try {
            if (Course::findOrFail($id))
                $userId = self::currentUser()->id;
            $entity = $this->queryHelper->buildQuery($this->model)
                                        ->with('customerLevel', 'specializeDetails.user',
                                               'specializeDetails.specialize')
                                        ->join('specialize_details', 'courses.specialize_detail_id',
                                               'specialize_details.id')
                                        ->join('specializes', 'specialize_details.specialize_id', 'specializes.id')
                                        ->join('customer_levels', 'courses.customer_level_id', 'customer_levels.id')
                                        ->join('users', 'specialize_details.user_id', 'users.id')
                                        ->select('courses.*')
                                        ->where(function ($query) use ($userId, $id) {
                                            $query->where('courses.id', '=', $id)
                                                  ->where('users.id', $userId);
                                        })->first();

            return $entity;
        } catch (ModelNotFoundException $e) {
            throw new NotFoundException(
                ['message' => __("not-exist", ['attribute' => __('entity')]) . ": $id"],
                $e
            );
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // get course request
    public function getCourseRequest()
    {
        $data = $this->queryHelper->buildQuery($this->model)
            // ->with(['stagesClient.course_planes_client'])
            // ->join('stages', 'stages.course_id', 'courses.id')
            // ->join('course_planes', 'course_planes.stage_id', 'stages.id')
            // ->where('courses.status', '!=', StatusConstant::PENDING)
                                  ->with(['teacher','customerLevel',  'specializeDetails',
                                         'specializeDetails.specialize', 'stagesClient.course_planes_client'])
                                  ->join('specialize_details', 'courses.specialize_detail_id',
                                         'specialize_details.id')
                                  ->join('specializes', 'specialize_details.specialize_id',
                                         'specializes.id')
                                  ->join('customer_levels', 'courses.customer_level_id',
                                         'customer_levels.id')
                                  ->join('users', 'specialize_details.user_id', 'users.id')
                                  ->where('courses.status', '!=', StatusConstant::PENDING)
                                  ->select('courses.*');
        try {
            $response = $data->get();

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // admin huy khoa hoc
    public function cancelRequestCourse(object $request, $id)
    {
        $course = Course::find($id);
        $user   = Auth::user();
        if (empty($course) || $user['id'] != $course->created_by) {
            throw new BadRequestException(
                ['message' => __("khoá học không tồn tại !")], new Exception()
            );
        }
        if (!($course->status == StatusConstant::REQUEST)) {
            throw new BadRequestException(
                ['message' => __("Chỉ huỷ yêu cầu khi khoá học đang ở trạng thái yêu cầu xét duyệt !")], new Exception()
            );
        }
        $course->update(['status' => StatusConstant::PENDING]);

        return $course;
    }

    public function requestCourse(object $request, $id)
    {
        /* ckeck xem ton tai khoa hoc ko
         * */

        $course = Course::find($id);
        $user   = Auth::user();
        if (empty($course) || $user['id'] != $course->created_by) {
            throw new BadRequestException(
                ['message' => __("khoá học không tồn tại !")], new Exception()
            );
        }
        if (!($course->status == StatusConstant::PENDING)) {
            throw new BadRequestException(
                ['message' => __("Chỉ được gửi yêu cầu khi khoá học đang ở trạng thái chờ !")], new Exception()
            );
        }
        if ($this->checkCoursePlanCurrentCourse($course->id) == true) {
            $course->update(['status' => StatusConstant::REQUEST]);

            return true;
        } else {
            throw new BadRequestException(
                ['message' => __("Hãy thêm đầy đủ giai đoạn và buổi học cho khoá học trước khi gửi yêu cầu xác nhận !")],
                new Exception()
            );
        }
    }

    public function checkCoursePlanCurrentCourse($course_id)
    {
        //  xem co stage nao ko va stage co buoi hoc nao ko
        // check stage nao cx phai có buoi hoc
        $check = 0;
        try {
            $stageArray = Stage::where('course_id', $course_id)->pluck('id')->toArray();
            if ($stageArray) {
                foreach ($stageArray as $item) {
                    $countCoursePlan = CoursePlanes::where('stage_id', $item)->get()->count();
                    if ($countCoursePlan > 0) {
                        $check++;
                    }
                }
                if ($check >= count($stageArray)) {
                    return true;
                }
            }

            return false;

        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function preAdd(object $request)
    {
        if ($request instanceof Request) {
            $request->merge([
                                'created_by' => $this->currentUser()->id ?? null,
                                'status'     => StatusConstant::PENDING
                            ]);
        } else {
            $request->created_by = $this->currentUser()->id ?? null;
            $request->status     = StatusConstant::PENDING;
        }
        parent::preAdd($request);
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $specialize_detail_id = SpecializeDetail::where('user_id', '=', $this->currentUser()->id)->pluck('id')
                                                ->toArray();

        $rules    = [
            'name'                 => [
                'required',
                Rule::unique('courses',)->where(function ($query) {
                    return $query->where('created_by', '=', $this->currentUser()->id);
                }),
            ],
            'image'                => 'required',
            'lessons'              => 'required|numeric|min:1',
            'time_a_lessons'       => 'required|numeric|min:30',
            'price'                => 'required|numeric|min:1',
            'description'          => 'required|min:3',
            'content'              => 'required|min:3',
            'display'              => 'in:' . implode(',', $this->display),
            'specialize_detail_id' => 'required|in:' . implode(',', $specialize_detail_id),
            'customer_level_id'    => 'required|exists:customer_levels,id'
        ];
        $messages = [
            'name.required' => 'Hãy nhập tên khoá học !',
            'name.unique'   => 'Tên khoá học này đã tồn tại !',

            'image.required' => 'Hãy nhập hình ảnh đại diện cho khoá học !',

            'lessons.required' => 'Hãy nhập tổng số buổi của khoá học !',
            'lessons.numeric'  => 'Tổng số buổi không hợp lệ !',
            'lessons.min'      => 'Tổng số buổi tối thiểu phải từ 1 !',

            'time_a_lessons.required' => 'Hãy nhập thời lượng 1 buổi học !',
            'time_a_lessons.numeric'  => 'Thời lượng buổi học không hợp lệ !',
            'time_a_lessons.min'      => 'Thời lượng buổi học phải tối thiểu 30 phút !',

            'price.required' => 'Hãy nhập giá tiền cho khoá học !',
            'price.numeric'  => 'Giá tiền không hợp lệ !',
            'price.min'      => 'Giá tiền không hợp lệ !',


            'description.required' => 'Hãy nhập mô tả cho khoá học !',
            'description.min'      => 'Mô tả phải từ 3 kí tự !',

            'content.required' => 'Hãy nhập nội dung khoá học !',
            'content.min'      => 'Nội dung phải từ 3 kí tự !',

            'status.in' => 'Trạng thái hoạt động không hợp lệ !',

            'display.in' => 'Trạng thái hiển thị không hợp lệ !',

            'specialize_detail_id.required' => 'Hãy chọn chuyên môn cho khoá học !',
            'specialize_detail_id.in'       => 'Chuyên môn không hợp lệ !',

            'customer_level_id.required' => 'Hãy nhập mức độ cho khoá học',
            'customer_level_id.exists'   => 'Mức độ không hợp lệ !',

        ];

        return parent::storeRequestValidate($request, $rules, $messages);
    }

    public function preUpdate(int|string $id, object $request)
    {
        $userId        = $this->currentUser()->id ?? null;
        $courseForUser = Course::where('created_by', '=', $userId)->where('id', '=', $id)->first();
        if (!$courseForUser) {
            throw new BadRequestException(
                ['message' => __("Khoá học không tồn tại !")], new Exception()
            );
        }

        if ($request instanceof Request) {
            $request->merge([
                                'created_by' => $this->currentUser()->id ?? null,
                                'status'     => $courseForUser->status
                            ]);
        } else {
            $request->created_by = $this->currentUser()->id ?? null;
            $request->status     = $courseForUser->status;
        }
        parent::preUpdate($id, $request);
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $specialize_detail_id = SpecializeDetail::where('user_id', '=', $this->currentUser()->id)->pluck('id')
                                                ->toArray();
        $rules                = [
            'name'                 => [
                'required',
                Rule::unique('courses',)->where(function ($query) use ($id) {
                    return $query->where('created_by', '=', $this->currentUser()->id)
                                 ->where('id', '!=', $id);
                }),
            ],
            'image'                => 'required',
            'lessons'              => 'required|numeric|min:1',
            'time_a_lessons'       => 'required|numeric|min:30',
            'price'                => 'required|numeric|min:1',
            'description'          => 'required|min:3',
            'content'              => 'required|min:3',
            // 'status'               => 'in:' . implode(',', $this->status),
            'display'              => 'in:' . implode(',', $this->display),
            'specialize_detail_id' => 'required|in:' . implode(',', $specialize_detail_id),
            'customer_level_id'    => 'required|exists:customer_levels,id'
        ];
        $messages             = [
            'name.required' => 'Hãy nhập tên khoá học !',
            'name.unique'   => 'Tên khoá học này đã tồn tại !',

            'image.required' => 'Hãy nhập hình ảnh đại diện cho khoá học !',

            'lessons.required'        => 'Hãy nhập tổng số buổi của khoá học !',
            'lessons.numeric'         => 'Tổng số buổi không hợp lệ !',
            'lessons.min'             => 'Tổng số buổi tối thiểu phải từ 1 !',
            'time_a_lessons.required' => 'Hãy nhập thời lượng 1 buổi học !',
            'time_a_lessons.numeric'  => 'Thời lượng buổi học không hợp lệ !',
            'time_a_lessons.min'      => 'Thời lượng buổi học phải tối thiểu 30 phút !',

            'price.required' => 'Hãy nhập giá tiền cho khoá học !',
            'price.numeric'  => 'Giá tiền không hợp lệ !',
            'price.min'      => 'Giá tiền không hợp lệ !',


            'description.required' => 'Hãy nhập mô tả cho khoá học !',
            'description.min'      => 'Mô tả phải từ 3 kí tự !',

            'content.required' => 'Hãy nhập nội dung khoá học !',
            'content.min'      => 'Nội dung phải từ 3 kí tự !',

            // 'status.in' => 'Trạng thái hoạt động không hợp lệ !',

            'display.in' => 'Trạng thái hiển thị không hợp lệ !',

            'specialize_detail_id.required' => 'Hãy chọn chuyên môn cho khoá học !',
            'specialize_detail_id.in'       => 'Chuyên môn không hợp lệ !',

            'customer_level_id.required' => 'Hãy nhập mức độ cho khoá học',
            'customer_level_id.exists'   => 'Mức độ không hợp lệ !',

        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages);
    }

    // update display index
    public function updateDisplay(object $request, $id)
    {
        $this->doValidate($request,
                          [
                              'display' => 'in:' . implode(',', $this->display),
                          ],
                          [
                              'display.in' => 'Trạng thái hiển thị không hợp lệ !',
                          ]
        );
        try {
            $course = Course::find($id);
            $course->update(['display' => $request->display]);

            return Course::find($id);
        } catch (Exception $exception) {
            throw new BadRequestException(
                ['message' => __("Update trạng thái hiển thị không thành công !")], new Exception()
            );
        }
    }

    public function updateCourseForAdmin($id, object $request)
    {
        $course = Course::findOrFail($id);
        if (!$course) {
            throw new BadRequestException(
                ['message' => __("Khoá học không tồn tại !")], new Exception()
            );
        }
        $this->doValidate($request,
                          [
                              'status' => 'in:' . implode(',', $this->status),
                          ],
                          [
                              'status.in' => 'Trạng thái hoạt động không hợp lệ !',
                          ]
        );

        return $course->update(['status' => $request->status]);
    }

    public function preDelete(int|string $id)
    {
        $userId                  = $this->currentUser()->id ?? null;
        $courseForUser           = Course::where('created_by', '=', $userId)->where('id', '=', $id)->first();
        $countStageCurrentCourse = Stage::where('course_id', $id)->count();
        if (!$courseForUser || $countStageCurrentCourse > 0) {
            throw new BadRequestException(
                ['message' => __("Xoá khoá học không thành công !")], new Exception()
            );
        }
        parent::preDelete($id);
    }

    public function getCoursePlanOff(object $request, $id)
    {
        try {
            $courseStudent = CourseStudent::find($id);
            $course        = Course::findOrFail($courseStudent->course_id);
            if ($course && $course->status == StatusConstant::HAPPENING && $course->display == StatusConstant::ACTIVE)
                $entity = $this->queryHelper->buildQuery($this->model)
                                            ->join('stages', 'courses.id', 'stages.course_id')
                                            ->join('course_planes', 'stages.id', 'course_planes.stage_id')
                                            ->where('stages.status', StatusConstant::ACTIVE)
                                            ->where('course_planes.status', StatusConstant::ACTIVE)
                                            ->where('course_planes.type', 0)
                                            ->select('course_planes.*')
                                            ->where('courses.id', $courseStudent->course_id)
                                            ->get();

            return $entity;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

}
