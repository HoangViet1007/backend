<?php

namespace App\Http\Controllers;

use App\Services\BaseService;
use App\Services\CustomerLevelService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CustomerLevelController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new CustomerLevelService();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(): JsonResponse
    {
        return response()->json($this->service->getAll());
    }

    public function getAllCustomerLevelNoPaginate(): JsonResponse
    {
        return response()->json($this->service->getAllCustomerLevelNoPaginate());
    }

    public function getCustomerLevel()
    {
        return response()->json($this->service->getCustomerLevel());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return JsonResponse
     */
    public function store(Request $request): JsonResponse
    {
        return response()->json($this->service->add($request));
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
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
     * @param \Illuminate\Http\Request $request
     * @param int                      $id
     *
     * @return JsonResponse
     */
    public function update(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->update($id, $request));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function destroy($id): JsonResponse
    {
        return response()->json($this->service->delete($id));
    }
}
