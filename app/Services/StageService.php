<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Course;
use App\Models\CoursePlanes;
use App\Services\BaseService;
use App\Models\Stage;
use Exception;
use Illuminate\Support\Facades\DB;
use App\Exceptions\BadRequestException;
use Illuminate\Validation\Rule;

class StageService extends BaseService
{
    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];

    function createModel(): void
    {
        $this->model = new Stage();
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'name' => [
                'required',
                Rule::unique('stages',)->where(function ($query) use ($request) {
                    return $query->where('course_id', $request->course_id);
                }),
            ],
            'short_content' => 'required',
            'content' => 'required',
            'status' => 'required|in:' . implode(',', $this->status),
            'course_id' => 'required|exists:courses,id'
        ];
        $messages = [
            'name.required' => 'Hãy nhập tiêu đề cho giai đoạn !',
            'name.unique' => 'Tiêu đề này đã tồn tại !',
            'short_content.required' => 'Hãy nhập mô tả ngắn cho giai đoạn !',
            'content.required' => 'Hãy nhập nội dung cho giai đoạn !',
            'status.required' => 'Hãy chọn trạng thái hoạt động !',
            'status.in' => 'Trạng thái hoạt động không hợp lệ !',
            'course_id.required' => 'Hãy chọn khóa học  !',
            'course_id.exists' => 'Khóa học không tồn tại !',
        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }


    public function updateRequestValidate(int|string $id, object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'name' => [
                'required',
                Rule::unique('stages',)->where(function ($query) use ($request, $id) {
                    return $query->where('course_id', $request->course_id)
                                 ->where('id', '!=', $id);
                }),
            ],
            'short_content' => 'required',
            'content' => 'required',
            'status' => 'required|in:' . implode(',', $this->status),
            'course_id' => 'required|exists:courses,id'
        ];

        $messages = [
            'name.required' => 'Hãy nhập tiêu đề cho giai đoạn !',
            'name.unique' => 'Tiêu đề này đã tồn tại !',
            'short_content.required' => 'Hãy nhập mô tả ngắn cho giai đoạn !',
            'content.required' => 'Hãy nhập nội dung cho giai đoạn !',
            'status.required' => 'Hãy chọn trạng thái hoạt động !',
            'status.in' => 'Trạng thái hoạt động không hợp lệ !',
            'course_id.required' => 'Hãy chọn khóa học  !',
            'course_id.exists' => 'Khóa học không tồn tại !',
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages); // TODO: Change the autogenerated stub
    }

    public function listStage($id)
    {
        $this->preGetAll();
        $data = $this->queryHelper->buildQuery($this->model)->where('course_id', $id)->where('status',StatusConstant::ACTIVE);
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function preDelete(int|string $id): bool
    {
        $checkDelete = CoursePlanes::where('stage_id', $id)->count();
        if ($checkDelete > 0) {
            throw new BadRequestException(
                ['message' => "Bạn không thể xóa được"], new Exception()
            );
        }
        return true;
    }

}
