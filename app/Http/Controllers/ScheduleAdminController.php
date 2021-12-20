<?php

namespace App\Http\Controllers;

use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Exceptions\ForbiddenException;
use App\Services\BaseService;
use App\Services\ScheduleService;
use App\Trait\RoleAndPermissionTrait;
use Exception;
use Illuminate\Http\Request;

class ScheduleAdminController extends Controller
{

    use RoleAndPermissionTrait;

    public BaseService $service;

    public function __construct()
    {
        $this->service = new ScheduleService();
    }


    public function listComplain()
    {
        if (!$this->hasPermission(PermissionConstant::complain(ActionConstant::LIST)))
            throw new ForbiddenException(__('Access denied'), new Exception());


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
