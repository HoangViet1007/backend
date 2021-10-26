<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Course;
use App\Models\CustomerLevel;
use Exception;

/**
 * @Author apple
 * @Date   Sep 30, 2021
 */
class CustomerLevelService extends BaseService
{

    function createModel(): void
    {
        $this->model = new CustomerLevel();
    }

    public function getAllCustomerLevelNoPaginate()
    {
        return CustomerLevel::all();
    }

    // get all customer for list course in client
    public function getCustomerLevel()
    {
        $data = $this->queryHelper->buildQuery($this->model);
        try {
            $response = $data->paginate(QueryHelper::limit());

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules    = [
            'name' => 'required|min:3|unique:customer_levels,name',
        ];
        $messages = [
            'name.required' => 'Hãy nhập tên cấp độ !',
            'name.min'      => 'Tên cấp độ phải tối thiểu từ 3 kí tự !',
            'name.unique'   => 'Tên cấp độ đã tồn tại !',
        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $rules = [
            'name' => "required|min:3|unique:customer_levels,name,$id",
        ];

        $messages = [
            'name.required' => 'Hãy nhập tên cấp độ !',
            'name.min'      => 'Tên cấp độ phải tối thiểu từ 3 kí tự !',
            'name.unique'   => 'Tên cấp độ đã tồn tại !',
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages);
    }

    public function preDelete(int|string $id)
    {
        $data = Course::where('customer_level_id', $id)->count();
        if ($data > 0) {
            throw new BadRequestException(
                ['message' => __("Xoá không thành công !")], new Exception()
            );
        }
    }

}
