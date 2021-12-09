<?php

namespace App\Http\Controllers;


use App\Services\BaseService;
use App\Services\ClientService;

class ClientController extends Controller
{
    public BaseService $service;

    protected $clientService;

    public function __construct()
    {
        $this->clientService = new ClientService();
    }


    /*
     Màn hình trang chủ
    */
    public function index()
    {
        return response()->json(['get_pt' => $this->clientService->get_pt_highlights(), 'get_course' => $this->clientService->get_course()]);
    }

    // danh sach pt



    public function detailPT($id)
    {
        return response()->json(['detail_pt' => $this->clientService->detailPT($id),'get_course' => $this->clientService->get_course()]);
    }
}
