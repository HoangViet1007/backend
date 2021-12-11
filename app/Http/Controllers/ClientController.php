<?php

namespace App\Http\Controllers;


use App\Services\BaseService;
use App\Services\ClientService;
use Illuminate\Http\JsonResponse;

class ClientController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new ClientService();
    }


    /*
     Màn hình trang chủ
    */
    public function index()
    {
        return response()->json(['get_pt' => $this->service->get_pt_highlights(), 'get_course' => $this->service->get_course()]);
    }

    // danh sach pt

    public function getListPtClient(): JsonResponse
    {
        return response()->json($this->service->getListPtClient());
    }


    public function detailPT($id)
    {
        return response()->json($this->service->detailPT($id));
    }

    public function getSettingClient(): JsonResponse
    {
        return response()->json($this->service->getSettingClient());
    }


}
