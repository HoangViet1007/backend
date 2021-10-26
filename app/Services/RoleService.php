<?php
namespace App\Services ;
use App\Models\Role;

/**
 * @Author apple
 * @Date   Oct 26, 2021
 */
class RoleService extends BaseService {

    function createModel(): void
    {
        $this->model = new Role() ;
    }

}
