<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Models\Course;
use App\Models\Payment;

/**
 * @Author apple
 * @Date   Oct 01, 2021
 */
class PaymentService extends BaseService
{
    function createModel(): void
    {
        $this->model = new Payment();
    }

    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            "money" => "required|numeric|min:0",
            "note" => "required",
            'course_id' => 'in:' . implode(',', Course::all()->id),
        ];
        $messages = [
            'money.required' => 'Số tiền không được trống !',
            'money.numeric' => 'Số tiền không hợp lệ !',
            'money.min' => 'Số tiền không hợp lệ !',
            'note.required' => 'Loại thannh toán không được để trống !',
            'course_id.in' => 'Khóa học thanh toán không hợp lệ !',
        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }
}