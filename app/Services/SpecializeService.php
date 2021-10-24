<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\SystemException;
use App\Models\Certificate;
use App\Models\Course;
use App\Models\Specialize;
use App\Models\SpecializeDetail;
use Exception;

/**
 * @Author apple
 * @Date   Oct 01, 2021
 */
class SpecializeService extends BaseService
{
    /**
     * @var array
     */
    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];

    function createModel(): void
    {
        $this->model = new Specialize();
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'name' => 'required|unique:specializes,name',
            'status' => 'required|in:' . implode(',', $this->status),
        ];
        $messages = [
            'name.required' => 'Hãy nhập tiêu đề cho chuyên môn !',
            'name.unique' => 'Tiêu đề này đã tồn tại !',
            'status.required' => 'Hãy chọn trạng thái hoạt động !',
            'status.in' => 'Trạng thái hoạt động không hợp lệ !'
        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'name' => "required|unique:specializes,name,$id",
            'status' => 'required|in:' . implode(',', $this->status),
        ];

        $messages = [
            'name.required' => 'Hãy nhập tiêu đề cho chuyên môn !',
            'name.unique' => 'Tiêu đề này đã tồn tại !',
            'status.required' => 'Hãy chọn trạng thái hoạt động !',
            'status.in' => 'Trạng thái hoạt động không hợp lệ !'
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages); // TODO: Change the autogenerated stub
    }

    public function preDelete(int|string $id)
    {
        $dataChildrenSpecializeDetail = SpecializeDetail::where('specialize_id', $id)->count();
        if ($dataChildrenSpecializeDetail > 0) {
            throw new BadRequestException(
                ['message' => 'Xóa không thành công !'], new Exception()
            );
        }
        parent::preDelete($id);
    }

    public function getAllUseSelectOption()
    {
        $this->preGetAll();
        $id = $this->currentUser()->id ?? null;
        $data = $this->queryHelper->buildQuery($this->model)->get();
        try {
            $this->postGetAll($data);
            return $data;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }
}
