<?php

namespace App\Services;

use App\Exceptions\BadRequestException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\ModelHasRole;
use App\Models\Role;
use App\Models\RoleHasPermission;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * @Author apple
 * @Date   Oct 26, 2021
 */
class RoleService extends BaseService
{

    function createModel(): void
    {
        $this->model = new Role();
    }

    public function getAll(): LengthAwarePaginator
    {
        $this->preGetAll();
        $data = $this->queryHelper->buildQuery($this->model)
                                  ->with(['users']);

        try {
            $response = $data->paginate(QueryHelper::limit());

            $response->getCollection()->transform(function ($value) {
                $value->count_user = count($value->users);
                unset($value->users);

                return $value;
            });

            $this->postGetAll($response);

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getById(int|string $id): Model
    {
        try {
            $entity = $this->model->with('permissions')->findOrFail($id);
            $entity->{'count_user'} = $this->countUserViaRoleId($id);

            $result = [];
            foreach ($entity->permissions as $permission) {
                $arrData               = explode(':', $permission['name']);
                $result[$arrData[0]][] = $permission['id'];
            }

            $entity->{'role_has_permissions'} = $result;

            return $entity;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function preAdd(object $request)
    {
        if ($request instanceof Request) {
            $request->merge(
                [
                    'is_mutable' => 0,
                ]
            );
        } else {
            $request->is_mutable = 0;
        }
        parent::preAdd($request);
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules    = [
            'name'             => 'required|unique:roles,name',
            'permission_ids'   => 'nullable|array',
            'permission_ids.*' => 'exists:permissions,id',
        ];
        $messages = [
            'name.required'           => 'H??y nh???p t??n ch???c v??? !',
            'name.unique'             => 'T??n ch???c v??? n??y ???? t???n t???i !',
            'permission_ids.array'    => 'Quy???n ???????c g??n cho ch???c v??? kh??ng h???p l??? !',
            'permission_ids.*.exists' => 'Quy???n ???????c g??n cho ch???c v??? kh??ng h???p l???  !',
        ];

        return parent::storeRequestValidate($request, $rules, $messages);
    }

    public function postAdd(object $request, Model $model)
    {
        if (isset($request->permission_ids)) {
            foreach ($request->permission_ids as $item) {
                $role_has_permissions                = new RoleHasPermission();
                $role_has_permissions->permission_id = $item;
                $role_has_permissions->role_id       = $model->id;
                $role_has_permissions->save();
            }
        }
        parent::postAdd($request, $model);
    }

    public function preUpdate(int|string $id, object $request)
    {
        $data = Role::find($id);
        if (!$data) {
            throw new BadRequestException(
                ['message' => __("Ch???c v??? n??y kh??ng t???n t???i !")], new Exception()
            );
        }

        if ($request instanceof Request) {
            $request->merge(
                [
                    'is_mutable' => 0,
                ]
            );
        } else {
            $request->is_mutable = 0;
        }
        parent::preUpdate($id, $request);
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $rules    = [
            'name'             => "required|unique:roles,name,$id",
            'permission_ids'   => 'sometimes|array',
            'permission_ids.*' => 'exists:permissions,id',
        ];
        $messages = [
            'name.required'           => 'H??y nh???p t??n ch???c v??? !',
            'name.unique'             => 'T??n ch???c v??? n??y ???? t???n t???i !',
            'permission_ids.array'    => 'Quy???n ???????c g??n cho ch???c v??? kh??ng h???p l??? !',
            'permission_ids.*.exists' => 'Quy???n ???????c g??n cho ch???c v??? kh??ng h???p l???  !',
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages);
    }

    public function postUpdate(int|string $id, object $request, Model $model)
    {
        if (isset($request->permission_ids)) {
            $role_has_per = RoleHasPermission::where('role_id', $model->id);
            $role_has_per->delete();
            foreach ($request->permission_ids as $item) {
                $role_has_permissions                = new RoleHasPermission();
                $role_has_permissions->permission_id = $item;
                $role_has_permissions->role_id       = $model->id;
                $role_has_permissions->save();
            }
        }
        parent::postUpdate($id, $request, $model);
    }

    public function preDelete(int|string $id)
    {
        $role = Role::find($id);
        if (!$role) {
            throw new BadRequestException(
                ['message' => __("Ch???c v??? n??y kh??ng t???n t???i !")], new Exception()
            );
        }
        if ($this->countUserViaRoleId($id) > 0 || $role->is_mutable == 1) {
            throw new BadRequestException(
                ['message' => __("Xo?? ch???c v??? kh??ng th??nh c??ng !")], new Exception()
            );
        }
        parent::preDelete($id);
    }

    public function postDelete(int|string $id)
    {
        DB::table('model_has_roles')->where('role_id', '=', $id)->delete();
        parent::postDelete($id);
    }

    private function countUserViaRoleId(int $roleId): int
    {
        $data = ModelHasRole::where('role_id',$roleId)->count();
        return $data;
    }

}
