<?php
namespace App\Services;

use App\Models\Permission;

class PermissionService extends BaseService
{

    function createModel(): void
    {
        $this->model = new Permission();
    }

    public function getAllPermission()
    {
        $permissions = Permission::all();

        $result      = [];
        foreach ($permissions as $permission) {
            $arrData               = explode(':', $permission['name']);
            $result[$arrData[0]][] = ['id' => $permission['id'], 'name' => $arrData[1]];
        }

        return $result;
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
