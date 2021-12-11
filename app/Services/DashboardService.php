<?php

namespace App\Services;

use App\Models\Demo;

/**
 * @Author apple
 * @Date   Sep 27, 2021
 */
class DashboardService extends BaseService
{

    function createModel(): void
    {
        $this->model = new Demo();
    }


    public function DashboardAdmin(){

    }
    public function DashboardPT(){}
    public function DashboardCustomer(){}}
