<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\BaseService;
use App\Services\SpecializeDetailService;
use Illuminate\Http\JsonResponse;

class SpecializeDetailController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new SpecializeDetailService();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(): JsonResponse
    {
        return response()->json($this->service->getAllByAdmin());
    }

    public function getAllByPt(): JsonResponse
    {
        return response()->json($this->service->getAllByPt());
    }

    public function getAllUseSelectOption(): JsonResponse
    {
        return response()->json($this->service->getAllUseSelectOption());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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
        return response()->json($this->service->getDetailByAdmin($id));
    }

    public function showByPt($id): JsonResponse
    {
        return response()->json($this->service->getDetailByPt($id));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
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
        return response()->json($this->service->deleteByAdmin($id));
    }

    public function destroyByPt($id): JsonResponse
    {
        return response()->json($this->service->delete($id));
    }

    public function restore($id){

    }

}
