<?php
/**
 * @Author apple
 * @Date   Sep 22, 2021
 */

namespace App\Services;

use App\Models\Demo;

class DemoService extends BaseService
{

    function createModel(): void
    {
        $this->model = new Demo();
    }

}
