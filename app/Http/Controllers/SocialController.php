<?php

namespace App\Http\Controllers;

use App\Services\BaseService;
use App\Services\SocialService;
use Illuminate\Http\Request;

class SocialController extends Controller
{
    public BaseService $service;
    public function __construct(){
        $this->service = new SocialService();
    }
    public function getAll(){
        return response()->json($this->service->getAllSocial());
    }
}
