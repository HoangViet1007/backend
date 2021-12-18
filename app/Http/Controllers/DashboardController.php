<?php

namespace App\Http\Controllers;


use App\Services\BaseService;
use App\Services\DashboardService;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new DashboardService();
    }

    public function DashboardAdmin(Request $request)
    {
        return response($this->service->DashboardAdmin($request));
    }

    public function DashboardPT(Request $request)
    {
        return response($this->service->DashboardPT($request));

    }

    public function DashboardCustomer(Request $request)
    {
        return response($this->service->DashboardCustomer($request));

    }

}
