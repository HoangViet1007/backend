<?php

namespace App\Services;

use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Constants\SexConstant;
use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\ForbiddenException;
use App\Exceptions\NotFoundException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Mail\GetPassword;
use App\Models\AccountLevel;
use App\Models\Course;
use App\Models\Role;
use App\Models\RoleHasPermission;
use App\Models\Social;
use App\Models\SpecializeDetail;
use App\Models\User;
use App\Models\UserSocial;
use App\Trait\RoleAndPermissionTrait;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;
use Symfony\Component\HttpKernel\Exception\HttpException;

/**
 * @Author apple
 * @Date   Oct 04, 2021
 */
class UserService extends BaseService
{

    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];
    protected array $sex    = [SexConstant::MALE, SexConstant::FEMALE];

    use RoleAndPermissionTrait;
    function createModel(): void
    {
        $this->model = new User();
    }

    public function getAll(): LengthAwarePaginator
    {
        if (!$this->hasPermission(PermissionConstant::user(ActionConstant::LIST)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        $this->preGetAll();
        $request      = \request()->all();
        $specializes  = $request['specializes__id__eq'] ?? null;
        $experience   = $request['specialize_details__experience__gt'] ?? null;
        $accountLevel = $request['account_levels__id__eq'] ?? null;
        $role         = $request['roles__id__eq'] ?? null;
        $data         = $this->queryHelper->buildQuery($this->model)
                                          ->with(['roles', 'specializeDetails.specialize', 'specializeDetails.certificates', 'accountLevels', 'specializeDetails.courses'])
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
                                          ->when($role, function ($q) {
                                              $q->leftJoin('specialize_details', 'users.id',
                                                           'specialize_details.user_id');
                                              $q->leftJoin('specializes', 'specializes.id',
                                                           'specialize_details.specialize_id');
                                              $q->leftJoin('model_has_roles', 'model_has_roles.user_id', 'users.id');
                                              $q->leftJoin('roles', 'roles.id', 'model_has_roles.role_id');
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
                = $this->model->with(['roles', 'specializeDetails.specialize', 'specializeDetails.certificates', 'accountLevels', 'specializeDetails.courses'])
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
                              'name'             => 'required|min:3|max:100',
                              'image'            => 'required',
                              'address'          => 'required|min:6|max:100',
                              'phone'            => ['required', 'regex:/(^[\+]{0,1}+(84){1}+[0-9]{9})|((^0)(32|33|34|35|36|37|38|39|56|58|59|70|76|77|78|79|81|82|83|84|85|86|88|89|90|92|91|93|94|96|97|98|99)+([0-9]{7}))$/'],
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
                              'name.max'             => 'Họ và tên tối đa chỉ 100 kí tự !',
                              'image.required'       => 'Hãy nhập hình ảnh !',
                              'address.required'     => 'Hãy nhập địa chỉ !',
                              'address.min'          => 'Địa chỉ phải tối thiểu 6 kí tự !',
                              'address.max'          => 'Địa chỉ tối đa chỉ 100 kí tự !',
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

        $request_role_ids = $request->role_ids ?? [];
        if ((in_array(2, $request_role_ids) == true && in_array(3, $request_role_ids))
            || (count($request_role_ids) > 1 && in_array(2, $request_role_ids))
            || (count($request_role_ids) > 1 && in_array(3, $request_role_ids))) {
            throw new BadRequestException(
                ['message' => __("Chỉ được chọn 1 chức vụ PT hoặc Customer !")], new Exception()
            );
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
        $model->sendEmailVerificationNotification();
    }

    public function preUpdate(int|string $id, object $request)
    {
        if (!$this->hasPermission(PermissionConstant::user(ActionConstant::EDIT)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        // check role input
        $request_role_ids = $request->role_ids ?? [];
        if (in_array(2, $request_role_ids) == true && in_array(3, $request_role_ids)) {
            throw new BadRequestException(
                ['message' => __("Không thể chọn đồng thời cả chức vụ PT và Customer !")],
                new Exception()
            );
        }
        parent::preUpdate($id, $request);
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $account_level = AccountLevel::where('status', StatusConstant::ACTIVE)->pluck('id')
                                     ->toArray();
        $rules         = [
            'name'             => 'required|min:3|max:100',
            'image'            => 'required',
            'address'          => 'required|min:6|max:100',
            'phone'            => ['required', 'regex:/(^[\+]{0,1}+(84){1}+[0-9]{9})|((^0)(32|33|34|35|36|37|38|39|56|58|59|70|76|77|78|79|81|82|83|84|85|86|88|89|90|92|91|93|94|96|97|98|99)+([0-9]{7}))$/'],
            'email'            => "required|email|unique:users,email,$id",
            'sex'              => 'required|in:' . implode(',', $this->sex),
            'status'           => 'required|in:' . implode(',', $this->status),
            // 'password'         => 'required|min:6',
            // 'cf_password'      => 'required|same:password',
            'role_ids'         => 'nullable|array',
            'role_ids.*'       => 'exists:roles,id',
            'account_level_id' => 'in:' . implode(',', $account_level),
        ];
        $messages      = [
            'name.required'       => 'Hãy nhập họ và tên !',
            'name.min'            => 'Họ và tên tối thiểu phải 3 kí tự !',
            'name.max'            => 'Họ và tên tối đa chỉ 100 kí tự !',
            'image.required'      => 'Hãy nhập hình ảnh !',
            'address.required'    => 'Hãy nhập địa chỉ !',
            'address.min'         => 'Địa chỉ phải tối thiểu 6 kí tự !',
            'address.max'         => 'Địa chỉ tối đa chỉ 100 kí tự !',
            'phone.required'      => 'Hãy nhập số điện thoại !',
            'phone.regex'         => 'Số điện thoại không hợp lệ !',
            'email.required'      => 'Hãy nhập địa chỉ email !',
            'email.email'         => 'Địa chỉ email không hợp lệ !',
            'email.unique'        => 'Địa chỉ email này đã tồn tại !',
            'sex.required'        => 'Hãy chọn trạng giới tính !',
            'sex.in'              => 'Giới tính không hợp lệ !',
            'status.required'     => 'Hãy chọn trạng thái hoạt động !',
            'status.in'           => 'Trạng thái hoạt động không hợp lệ !',
            // 'password.required'    => 'Hãy nhập mật khẩu !',
            // 'cf_password.required' => 'Hãy nhập lại mật khẩu !',
            // 'cf_password.same'     => 'Nhập lại mật khẩu không hợp lệ !',
            // 'password.min'         => 'Mật khẩu phải tối thiểu 6 kí tự !',
            'role_ids.array'      => 'Chức vụ không hợp lệ !',
            'role_ids.*.exists'   => 'Chức vụ :attribute không  tồn tại !',
            'account_level_id.in' => 'Cấp độ tài khoản không hợp lệ !'

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
                              'name'        => 'required|min:3',
                              'image'       => 'required',
                              'address'     => 'required',
                              'phone'       => 'required|regex:/(0)[0-9]{9}/',
                              'sex'         => 'required|in:' . implode(',', $this->sex),
                              'description' => 'min:3'
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
                              'description.min'  => 'Nội dung giới thiệu phải tối thiểu 3 kí tự !'
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
            $this->postEditUser($id, $request, $model);
            DB::commit();

            return $model;
        } catch (Exception $e) {
            DB::rollBack();
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }

    }


    public function postEditUser(int|string $id, object $request, Model $model)
    {
        if (isset($request->socials)) {
            $userSocial = UserSocial::where('user_id', $id);
            $userSocial->delete();
            if (count($request->socials) > 0) {
                foreach ($request->socials as $item) {
                    $data            = new UserSocial();
                    $data->link      = $item['link'];
                    $data->user_id   = $id;
                    $data->social_id = $item['id'];
                    $data->save();
                }
            } else {
                $userSocial = UserSocial::where('user_id', $id);
                $userSocial->delete();
            }
        } else {
            $userSocial = UserSocial::where('user_id', $id);
            $userSocial->delete();
        }
    }

    public function preDelete(int|string $id)
    {
        if (!$this->hasPermission(PermissionConstant::user(ActionConstant::DELETE)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        $countSpecializeDetailCurrentUser = SpecializeDetail::where('user_id', $id)->count();
        $countCourse                      = Course::where('created_by', $id)->count();

        if (($countSpecializeDetailCurrentUser > 0) || ($countCourse > 0)) {
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
            $entity                 = $this->model->with(['roles', 'accountLevels', 'socials.userSocials'])
                                                  ->findOrFail($request->user()->id);
            $entity->{'social_all'} = Social::all();

            $entity->{'array_permissions'} = $this->getPermissionInfoUserLogin($entity->roles);

            return $entity;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getPermissionInfoUserLogin($value)
    {
        $arrayPer                = [];
        $namePerCurrentUserLogin = [];
        foreach ($value as $item) {
            $data = Role::find($item->id);
            array_push($arrayPer, $data->id);
            $per = RoleHasPermission::where('role_id', $data->id)
                                    ->join('permissions', 'permissions.id', 'role_has_permissions.permission_id')
                                    ->get();
            foreach ($per as $item2){
                array_push($namePerCurrentUserLogin,$item2->name);
            }
        }

        return array_unique($namePerCurrentUserLogin);
    }

    public function updatePassword(object $request)
    {
        $this->doValidate($request,
                          [
                              'old_password' => 'required|min:6',
                              'new_password' => 'required|min:6',
                              'cf_password'  => 'required|same:new_password',
                          ],
                          [
                              'old_password.required' => 'Hãy nhập mật khẩu !',
                              'old_password.min'      => 'Mật khẩu phải tối thiểu 6 kí tự !',
                              'new_password.required' => 'Hãy nhập mật khẩu mới !',
                              'new_password.min'      => 'Mật khẩu mới phải tối thiểu 6 kí tự !',
                              'cf_password.required'  => 'Hãy nhập lại mật khẩu mới !',
                              'cf_password.same'      => 'Nhập lại mật khẩu mới không hợp lệ !',
                          ]
        );
        try {
            $user = Auth::user();
            if (Hash::check($request->old_password, $user['password'])) {
                // đổi mk
                $userChangePass           = User::find($user['id']);
                $userChangePass->password = Hash::make($request->new_password);
                $userChangePass->save();

                return true;
            } else {
                throw new HttpException(500, 'Mật khẩu cũ không đúng !');
            }
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getPassword($request)
    {
        $this->doValidate($request,
                          [
                              'email' => 'required|email',
                          ],
                          [
                              'email.required' => 'Xin mời bạn nhập email !',
                              'email.email'    => 'Xin mời bạn nhập email đúng định dạng !',
                          ]
        );

        try {

            $email = $request['email'];
            $user  = User::where('email', $email)->first();
            if ($user && $user->email_verified_at) {
                // đổi mk
                $password = Str::random(10);
                $user->update(['password' => Hash::make($password)]);

                Mail::to($user->email)->send(new GetPassword($user->name, $password));

                return true;

            } else {
                throw new HttpException(500, 'Email không tồn tại !');
            }
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

}
