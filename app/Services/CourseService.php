<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\NotFoundException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Course;
use App\Models\SpecializeDetail;
use App\Models\Stage;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

/**
 * @Author apple
 * @Date   Oct 06, 2021
 */
class CourseService extends BaseService
{
    protected array $status  = [StatusConstant::HAPPENING, StatusConstant::PENDING, StatusConstant::PAUSE];
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
            $response = $data->paginate(QueryHelper::limit());

            $response->getCollection()->transform(function ($value) {
                $value->total_stages = count($value->stages);
                unset($value->stages);

                return $value;
            });

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    // get courses in client
    public function getCourse()
    {
        $this->preGetAll();
        $statusActive      = StatusConstant::ACTIVE;
        $statusHappening   = StatusConstant::HAPPENING;
        $request           = request()->all();
        $specializesId     = $request['specializes__id__eq'] ?? null;
        $customer_levelsId = $request['customer_levels__id__eq'] ?? null;

        $data = $this->queryHelper->removeParam('specializes__id__eq')->removeParam('customer_levels__id__eq')->buildQuery($this->model)
                                  ->with(['customerLevel', 'specializeDetails.user',
                                          'specializeDetails.specialize'])
                                  ->join('specialize_details', 'courses.specialize_detail_id',
                                         'specialize_details.id')
                                  ->join('specializes', 'specialize_details.specialize_id',
                                         'specializes.id')
                                  ->join('customer_levels', 'courses.customer_level_id',
                                         'customer_levels.id')
                                  ->join('users', 'specialize_details.user_id', 'users.id')
                                  ->select('courses.*')
                                  ->when($specializesId, function ($q) use ($specializesId) {
                                      $q->whereIn('specializes.id', $specializesId);
                                  })
                                  ->when($customer_levelsId, function ($q) use ($customer_levelsId) {
                                      $q->whereIn('customer_levels.id', $customer_levelsId);
                                  })
                                  ->where(function ($query) use ($statusActive, $statusHappening) {
                                      $query->where('courses.display', $statusActive)
                                            ->where('courses.status', $statusHappening);
                                  });
        // dd($data->toSql());
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
            if ($course && $course->status == StatusConstant::HAPPENING && $course->status == StatusConstant::ACTIVE)
                $entity = $this->queryHelper->buildQuery($this->model)
                                            ->with(['customerLevel', 'specializeDetails.user',
                                                    'specializeDetails.specialize', 'cousre_planes'])
                                            ->join('specialize_details', 'courses.specialize_detail_id',
                                                   'specialize_details.id')
                                            ->join('specializes', 'specialize_details.specialize_id', 'specializes.id')
                                            ->join('customer_levels', 'courses.customer_level_id', 'customer_levels.id')
                                            ->join('users', 'specialize_details.user_id', 'users.id')
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
                                'status'     => StatusConstant::PENDING
                            ]);
        } else {
            $request->created_by = $this->currentUser()->id ?? null;
            $request->status     = StatusConstant::PENDING;
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
            'status'               => 'in:' . implode(',', $this->status),
            'display'              => 'in:' . implode(',', $this->display),
            'specialize_detail_id' => 'required|in:' . implode(',', $specialize_detail_id),
            'customer_level_id'    => 'required|exists:customer_levels,id'
        ];
        $messages             = [
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

        return parent::updateRequestValidate($id, $request, $rules, $messages);
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

}
