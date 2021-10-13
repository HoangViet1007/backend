<?php

namespace App\Services;

use App\Constants\SexConstant;
use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\SystemException;
use App\Models\SpecializeDetail;
use App\Models\User;
use Exception;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

/**
 * @Author apple
 * @Date   Oct 04, 2021
 */
class UserService extends BaseService
{

    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];
    protected array $sex    = [SexConstant::MALE, SexConstant::FEMALE];

    function createModel(): void
    {
        $this->model = new User();
    }

    /**
     * @param object $request
     */
    public function preAddUser(object $request)
    {
        if ($request instanceof Request) {
            $request->merge(['password' => Hash::make($request->password)]);
        } else {
            $request->password = Hash::make($request->password);
        }
    }

    public function addUser(object $request, array $role_ids = []): Model
    {
        DB::beginTransaction();
        $request = $this->preAddUser($request) ?? $request;
        // Set data to new entity

        $fillAbles = $this->model->getFillable();
        $guarded   = $this->model->getGuarded();

        // Validate
        if ($this->storeRequestValidate($request) !== true)
            return $this->model;

        foreach ($fillAbles as $fillAble)
            if (isset($request->$fillAble) && !in_array($fillAble, $guarded))
                $this->model->$fillAble = $this->_handleRequestData($request->$fillAble);
        try {
            $this->model->save();
            $this->postAddUser($request, $this->model, $role_ids);
            DB::commit();

            return $this->model;
        } catch (Exception $e) {
            DB::rollBack();
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function postAddUser(object $request, Model $model, array $role_ids = [])
    {
        if (isset($role_ids)) {
            $model->roles()->attach($role_ids);
        }
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules    = [
            'name'       => 'required|min:3',
            'image'      => 'required',
            'address'    => 'required',
            'phone'      => 'required|regex:/(0)[0-9]{9}/',
            'email'      => 'required|email|unique:users,email',
            'sex'        => 'required|in:' . implode(',', $this->sex),
            'status'     => 'required|in:' . implode(',', $this->status),
            'password'   => 'required|min:6',
            'role_ids'   => 'nullable|array',
            'role_ids.*' => 'exists:roles,id',
        ];
        $messages = [
            'name.required'     => 'Hãy nhập họ và tên !',
            'name.min'          => 'Họ và tên tối thiểu phải 3 kí tự !',
            'image.required'    => 'Hãy nhập hình ảnh !',
            'address.required'  => 'Hãy nhập địa chỉ !',
            'phone.required'    => 'Hãy nhập số điện thoại !',
            'phone.regex'       => 'Số điện thoại không hợp lệ !',
            'email.required'    => 'Hãy nhập địa chỉ email !',
            'email.email'       => 'Địa chỉ email không hợp lệ !',
            'email.unique'      => 'Địa chỉ email đã tồn tại !',
            'sex.required'      => 'Hãy chọn trạng giới tính !',
            'sex.in'            => 'Giới tính không hợp lệ !',
            'status.required'   => 'Hãy chọn trạng thái hoạt động !',
            'status.in'         => 'Trạng thái hoạt động không hợp lệ !',
            'password.required' => 'Hãy nhập mật khẩu !',
            'password.min'      => 'Mật khẩu phải tối thiểu 6 kí tự !',
            'role_ids.array'    => 'Chức vụ không hợp lệ !',
            'role_ids.*.exists' => 'Chức vụ :attribute không  tồn tại !'
        ];

        return parent::storeRequestValidate($request, $rules, $messages);
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $rules    = [
            'name'       => 'required|min:3',
            'image'      => 'required',
            'address'    => 'required',
            'phone'      => 'required|regex:/(0)[0-9]{9}/',
            'email'      => "required|email|unique:users,email,$id",
            'sex'        => 'required|in:' . implode(',', $this->sex),
            'status'     => 'required|in:' . implode(',', $this->status),
            'password'   => 'required|min:6',
            'role_ids'   => 'nullable|array',
            'role_ids.*' => 'exists:roles,id',
        ];
        $messages = [
            'name.required'     => 'Hãy nhập họ và tên !',
            'name.min'          => 'Họ và tên tối thiểu phải 3 kí tự !',
            'image.required'    => 'Hãy nhập hình ảnh !',
            'address.required'  => 'Hãy nhập địa chỉ !',
            'phone.required'    => 'Hãy nhập số điện thoại !',
            'phone.regex'       => 'Số điện thoại không hợp lệ !',
            'email.required'    => 'Hãy nhập địa chỉ email !',
            'email.email'       => 'Địa chỉ email không hợp lệ !',
            'email.unique'      => 'Địa chỉ email này đã tồn tại !',
            'sex.required'      => 'Hãy chọn trạng giới tính !',
            'sex.in'            => 'Giới tính không hợp lệ !',
            'status.required'   => 'Hãy chọn trạng thái hoạt động !',
            'status.in'         => 'Trạng thái hoạt động không hợp lệ !',
            'password.required' => 'Hãy nhập mật khẩu !',
            'password.min'      => 'Mật khẩu phải tối thiểu 6 kí tự !',
            'role_ids.array'    => 'Chức vụ không hợp lệ !',
            'role_ids.*.exists' => 'Chức vụ :attribute không  tồn tại !'
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages);
    }

    public function postUpdate(int|string $id, object $request, Model $model)
    {
        if (isset($request->role_ids)) {
            $model->roles()->sync($request->role_ids);
            parent::postUpdate($id, $request, $model);
        }
    }

    public function editUser($id, object $request)
    {
        $this->doValidate($request,
                          [
                              'name'    => 'required|min:3',
                              'image'   => 'required',
                              'address' => 'required',
                              'phone'   => 'required|regex:/(0)[0-9]{9}/',
                              'sex'     => 'required|in:' . implode(',', $this->sex),
                          ],
                          [
                              'name.required'    => 'Hãy nhập họ và tên !',
                              'name.min'         => 'Họ và tên tối thiểu phải 3 kí tự !',
                              'image.required'   => 'Hãy nhập hình ảnh !',
                              'address.required' => 'Hãy nhập địa chỉ !',
                              'phone.required'   => 'Hãy nhập số điện thoại !',
                              'phone.regex'      => 'Số điện thoại không hợp lệ !',
                              'sex.required'     => 'Hãy chọn trạng giới tính !',
                              'sex.in'           => 'Giới tính không hợp lệ !',
                          ]);

        DB::beginTransaction();
        // Set data for updated entity
        $fillAbles = $this->model->getFillable();
        $guarded   = $this->model->getGuarded();

        $model = $this->get($id);

        foreach ($fillAbles as $fillAble) {
            if (isset($request->$fillAble) && !in_array($fillAble, $guarded)) {
                $model->$fillAble = $this->_handleRequestData($request->$fillAble) ?? $model->$fillAble;
            }
        }

        try {
            $model->save();
            DB::commit();

            return $model;
        } catch (Exception $e) {
            DB::rollBack();
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }

    }

    public function preDelete(int|string $id)
    {
        $countSpecializeDetailCurrentUser = SpecializeDetail::where('user_id', $id)->count();
        if ($countSpecializeDetailCurrentUser > 0) {
            throw new BadRequestException(
                ['message' => __("Xoá tài khoản không thành công !")], new Exception()
            );
        }
        parent::preDelete($id);
    }

    public function postDelete(int|string $id)
    {
        DB::table('model_has_roles')->where('user_id', '=', $id)->delete();
        parent::postDelete($id);
    }

    public function getCurrentUserInformation(object $request): object
    {
        try {
            $user = $this->get($request->user()->id);

            return $user;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

}
