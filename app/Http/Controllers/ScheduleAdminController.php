<?php

namespace App\Http\Controllers;

use App\Services\BaseService;
use Illuminate\Http\Request;
use App\Services\ScheduleService;

class ScheduleAdminController extends Controller
{

    public BaseService $service;

    public function __construct()
    {
        $this->service = new ScheduleService();
    }


    public function listComplain()
    {
        $data = $this->service->listComplain();
        $data->map(function ($item) {
            $checkRecrod = false;
            if ($item->link_record == null) {
                $checkRecrod = true;
            };
            $item['checkRecrod'] = $checkRecrod;

            return $item;

        });

        return $data;

    }


    // yêu cầu khiếu nại

    public function changeComplain(Request $request)
    {
        return $this->service->changeComplain($request);
    }

}
