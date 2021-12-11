<?php

namespace App\Http\Controllers;


use App\Services\BaseService;
use App\Services\DashboardService;

class DashboardController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new DashboardService();
    }

    public function DashboardAdmin()
    {
        return response($this->service->DashboardAdmin());
    }

    public function DashboardPT()
    {
        return response($this->service->DashboardPT());

    }

    public function DashboardCustomer()
    {
        return response($this->service->DashboardCustomer());

    }

}
