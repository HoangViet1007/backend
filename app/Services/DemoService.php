<?php

namespace App\Services;

use App\Models\Demo;

/**
 * @Author apple
 * @Date   Sep 27, 2021
 */
class DemoService extends BaseService
{

    function createModel(): void
    {
        $this->model = new Demo() ;
    }
}
