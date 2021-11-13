<?php

namespace App\Http\Controllers;

use App\Services\BaseService;
use App\Services\CourseStudentService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CourseStudentController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new CourseStudentService();
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

    public function getCourseForCustomer(): JsonResponse
    {
        return response()->json($this->service->getCourseForCustomer());
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
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        return response()->json($this->service->createCourseStudent($request));
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     *
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     *
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int                      $id
     *
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    public function customerCancel(Request $request, $id)
    {
        return response()->json($this->service->customerCancel($request, $id));
    }

    public function ptCancel(Request $request, $id)
    {
        return response()->json($this->service->ptCancel($request, $id));
    }

    // pt duyet dang ký khoa hoc
    public function ptThough(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->ptThough($request, $id));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     *
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
