<?php

namespace App\Services;

use App\Constants\SexConstant;
use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\NotFoundException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\AccountLevel;
use App\Models\SpecializeDetail;
use App\Models\User;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\ModelNotFoundException;
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

    public function getAll(): LengthAwarePaginator
    {
        $this->preGetAll();
        $request      = \request()->all();
        $specializes  = $request['specializes__id__eq'] ?? null;
        $experience   = $request['specialize_details__experience__gt'] ?? null;
        $accountLevel = $request['account_levels__id__eq'] ?? null;
        $data         = $this->queryHelper->buildQuery($this->model)
                                          ->with(['roles', 'specializeDetails.specialize', 'specializeDetails.certificates', 'accountLevels','specializeDetails.courses'])
                                          ->when($specializes, function ($q) {
                                              $q->leftJoin('specialize_details', 'users.id',
                                                           'specialize_details.user_id');
                                              $q->leftJoin('specializes', 'specializes.id',
                                                           'specialize_details.specialize_id');
                                              $q->distinct();
                                          })
                                          ->when($experience, function ($q) {
                                              $q->leftJoin('specialize_details', 'users.id',
                                                           'specialize_details.user_id');
                                              $q->leftJoin('specializes', 'specializes.id',
                                                           'specialize_details.specialize_id');
                                              $q->distinct();
                                          })
                                          ->when($accountLevel, function ($q) {
                                              $q->leftJoin('specialize_details', 'users.id',
                                                           'specialize_details.user_id');
                                              $q->leftJoin('specializes', 'specializes.id',
                                                           'specialize_details.specialize_id');
                                              $q->leftJoin('account_levels', 'users.account_level_id',
                                                           'account_levels.id');
                                              $q->distinct();
                                          })
                                          ->select('users.*');
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function get(int|string $id): Model
    {
        $this->preGet($id);
        try {
            $entity
                = $this->model->with(['roles', 'specializeDetails.specialize', 'specializeDetails.certificates', 'accountLevels','specializeDetails.courses'])
                              ->findOrFail($id);
            $this->postGet($id, $entity);

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

    /**
     * @param object $request
     */

    public function addUser(object $request, array $role_ids = [], $account_level_id = null): Model
    {
        DB::beginTransaction();
        $request = $this->preAddUser($request) ?? $request;
        // check role input
        $request_role_ids = $request->role_ids ?? [];
        if (count($request_role_ids) > 0) {
            $role_ids = $request_role_ids;
        }
        // Set data to new entity

        $fillAbles = $this->model->getFillable();
        $guarded   = $this->model->getGuarded();

        foreach ($fillAbles as $fillAble)
            if (isset($request->$fillAble) && !in_array($fillAble, $guarded))
                $this->model->$fillAble = $this->_handleRequestData($request->$fillAble);
        try {
            $this->model->save();
            $this->postAddUser($request, $this->model, $role_ids, $account_level_id);
            DB::commit();

            return $this->model;
        } catch (Exception $e) {
            DB::rollBack();
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }


    public function preAddUser(object $request)
    {
        $account_level = AccountLevel::where('status', StatusConstant::ACTIVE)->pluck('id')
                                     ->toArray();
        $this->doValidate($request,
                          [
                              'name'             => 'required|min:3',
                              'image'            => 'required',
                              'address'          => 'required',
                              'phone'            => 'required|regex:/(0)[0-9]{9}/',
                              'email'            => 'required|email|unique:users,email',
                              'sex'              => 'required|in:' . implode(',', $this->sex),
                              'role_ids'         => 'nullable|array',
                              'role_ids.*'       => 'exists:roles,id',
                              'password'         => 'required|min:6',
                              'cf_password'      => 'required|same:password',
                              'account_level_id' => 'in:' . implode(',', $account_level),
                          ],
                          [
                              'name.required'        => 'Hãy nhập họ và tên !',
                              'name.min'             => 'Họ và tên tối thiểu phải 3 kí tự !',
                              'image.required'       => 'Hãy nhập hình ảnh !',
                              'address.required'     => 'Hãy nhập địa chỉ !',
                              'phone.required'       => 'Hãy nhập số điện thoại !',
                              'phone.regex'          => 'Số điện thoại không hợp lệ !',
                              'email.required'       => 'Hãy nhập địa chỉ email !',
                              'email.email'          => 'Địa chỉ email không hợp lệ !',
                              'email.unique'         => 'Địa chỉ email đã tồn tại !',
                              'sex.required'         => 'Hãy chọn trạng giới tính !',
                              'sex.in'               => 'Giới tính không hợp lệ !',
                              'status.required'      => 'Hãy chọn trạng thái hoạt động !',
                              'role_ids.array'       => 'Chức vụ không hợp lệ !',
                              'role_ids.*.exists'    => 'Chức vụ :attribute không  tồn tại !',
                              'password.required'    => 'Hãy nhập mật khẩu !',
                              'password.min'         => 'Mật khẩu phải tối thiểu 6 kí tự !',
                              'cf_password.required' => 'Hãy nhập lại mật khẩu !',
                              'cf_password.same'     => 'Nhập lại mật khẩu không hợp lệ !',
                              'account_level_id.in'  => 'Cấp độ tài khoản không hợp lệ !'
                          ]
        );
        if ($request instanceof Request) {
            $request->merge(
                [
                    'password' => Hash::make($request->password),
                    'status'   => StatusConstant::ACTIVE
                ]
            );
        } else {
            $request->password = Hash::make($request->password);
            $request->status   = StatusConstant::ACTIVE;
        }
    }

    public function postAddUser(object $request, Model $model, array $role_ids, $account_level_id)
    {
        if (isset($role_ids)) {
            $model->roles()->attach($role_ids);
        }
        if (isset($account_level_id)) {
            $model->update(['account_level_id' => $account_level_id]);
        }
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $account_level = AccountLevel::where('status', StatusConstant::ACTIVE)->pluck('id')
                                     ->toArray();
        $rules         = [
            'name'             => 'required|min:3',
            'image'            => 'required',
            'address'          => 'required',
            'phone'            => 'required|regex:/(0)[0-9]{9}/',
            'email'            => "required|email|unique:users,email,$id",
            'sex'              => 'required|in:' . implode(',', $this->sex),
            'status'           => 'required|in:' . implode(',', $this->status),
            'password'         => 'required|min:6',
            'cf_password'      => 'required|same:password',
            'role_ids'         => 'nullable|array',
            'role_ids.*'       => 'exists:roles,id',
            'account_level_id' => 'in:' . implode(',', $account_level),
        ];
        $messages      = [
            'name.required'        => 'Hãy nhập họ và tên !',
            'name.min'             => 'Họ và tên tối thiểu phải 3 kí tự !',
            'image.required'       => 'Hãy nhập hình ảnh !',
            'address.required'     => 'Hãy nhập địa chỉ !',
            'phone.required'       => 'Hãy nhập số điện thoại !',
            'phone.regex'          => 'Số điện thoại không hợp lệ !',
            'email.required'       => 'Hãy nhập địa chỉ email !',
            'email.email'          => 'Địa chỉ email không hợp lệ !',
            'email.unique'         => 'Địa chỉ email này đã tồn tại !',
            'sex.required'         => 'Hãy chọn trạng giới tính !',
            'sex.in'               => 'Giới tính không hợp lệ !',
            'status.required'      => 'Hãy chọn trạng thái hoạt động !',
            'status.in'            => 'Trạng thái hoạt động không hợp lệ !',
            'password.required'    => 'Hãy nhập mật khẩu !',
            'cf_password.required' => 'Hãy nhập lại mật khẩu !',
            'cf_password.same'     => 'Nhập lại mật khẩu không hợp lệ !',
            'password.min'         => 'Mật khẩu phải tối thiểu 6 kí tự !',
            'role_ids.array'       => 'Chức vụ không hợp lệ !',
            'role_ids.*.exists'    => 'Chức vụ :attribute không  tồn tại !',
            'account_level_id.in'  => 'Cấp độ tài khoản không hợp lệ !'

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
            $entity = $this->model->with('roles')->findOrFail($request->user()->id);

            return $entity;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

}
