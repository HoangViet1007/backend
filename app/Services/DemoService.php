<?php
/**
 * @Author apple
 * @Date   Sep 20, 2021
 */

namespace App\Services;

use App\Models\Demo;

class DemoService extends BaseService
{

    function createModel(): void
    {
        $this->model = new Demo() ;
    }
}

