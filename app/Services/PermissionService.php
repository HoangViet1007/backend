<?php
namespace App\Services;

use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Exceptions\ForbiddenException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Permission;
use App\Trait\RoleAndPermissionTrait;
use Exception;

class PermissionService extends BaseService
{

    use RoleAndPermissionTrait;
    function createModel(): void
    {
        $this->model = new Permission();
    }

    public function getAllPermission()
    {
        $permissions = Permission::all();

        $result = [];
        foreach ($permissions as $permission) {
            $arrData               = explode(':', $permission['name']);
            $result[$arrData[0]][] = ['id' => $permission['id'], 'name' => $permission->name];
        }

        return $result;
    }

    public function getAllPermissionNoPaginate()
    {
        return Permission::all();
    }

    public function getAllPermission2()
    {
        $data = $this->queryHelper->buildQuery($this->model);
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $this->doValidate($request,
                          [
                              'name'         => 'required|unique:permissions,name',
                              'display_name' => 'required'
                          ],
                          [
                              'name.required'         => 'Hãy nhập tên quyền !',
                              'display_name.required' => 'Hãy nhập mô tả cho quyền !'
                          ]
        );

        return parent::storeRequestValidate($request, $rules, $messages);
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $this->doValidate($request,
                          [
                              'name'         => "required|unique:permissions,name,$id",
                              'display_name' => 'required'
                          ],
                          [
                              'name.required'         => 'Hãy nhập tên quyền !',
                              'display_name.required' => 'Hãy nhập mô tả cho quyền !'
                          ]
        );

        return parent::updateRequestValidate($id, $request, $rules, $messages);
    }
}

?>
