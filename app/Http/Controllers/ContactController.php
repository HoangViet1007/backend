<?php

namespace App\Http\Controllers;

use App\Services\BaseService;
use App\Services\ContactService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ContactController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new ContactService();
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(): JsonResponse
    {
        return response()->json($this->service->getAll()) ;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     *
     * @return JsonResponse
     */
    public function store(Request $request): JsonResponse
    {
        return response()->json($this->service->add($request));
    }

    public function sendEmailContact(Request $request){
        return response()->json($this->service->sendEmailContact($request));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     *
     * @return JsonResponse
     */
    public function show($id): JsonResponse
    {
        return response()->json($this->service->get($id));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     *
     * @return JsonResponse
     */
    public function update($id, Request $request): JsonResponse
    {
        return response()->json($this->service->update($id, $request));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     *
     * @return JsonResponse
     */
    public function destroy($id): JsonResponse
    {
        return response()->json($this->service->delete($id));
    }
}
