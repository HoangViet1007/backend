<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Models\Contact;

/**
 * @Author apple
 * @Date   Sep 30, 2021
 */
class ContactService extends BaseService
{
    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];

    function createModel(): void
    {
        $this->model = new Contact();
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'name'    => 'required|string|min:3',
            'address' => 'required',
            'phone'   => 'required|regex:/(0)[0-9]{9}/',
            'email'   => 'required|email',
            'title'   => 'required',
            'content' => 'required',
            'status'  => 'required|in:' . implode(',', $this->status),
        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $rules = [
            'name'    => 'required|string|min:3',
            'address' => 'required',
            'phone'   => 'required|regex:/(0)[0-9]{9}/',
            'email'   => 'required|email',
            'title'   => 'required',
            'content' => 'required',
            'status'  => 'required|in:' . implode(',', $this->status),
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages); // TODO: Change the autogenerated stub
    }

}
