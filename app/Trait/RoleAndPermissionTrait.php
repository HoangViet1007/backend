<?php
namespace App\Trait;

use App\Models\Permission;
use App\Services\BaseService;

trait RoleAndPermissionTrait
{
    /**
     * check current user has any permissions ?
     *
     * @param $permissionName
     *
     * @return bool
     */
    public function hasPermission($permissionName): bool
    {
        $permission = Permission::join('role_has_permissions', 'role_has_permissions.permission_id', '=',
                                       'permissions.id')
                                ->join('roles', 'role_has_permissions.role_id', '=', 'roles.id')
                                ->join('model_has_roles', 'model_has_roles.role_id', '=', 'roles.id')
                                ->where('model_has_roles.model_id', BaseService::currentUser()?->id)
                                ->where('permissions.name', $permissionName)
                                ->first();

        return isset($permission);
    }
}

?>
