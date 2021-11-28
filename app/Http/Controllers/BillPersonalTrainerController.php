<?php

namespace App\Http\Controllers;

use App\Services\BaseService;
use App\Services\CourseStudentService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Services\BillPersonalTrainerService;

class BillPersonalTrainerController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public BaseService $service;

    public function __construct()
    {
        $this->service = new BillPersonalTrainerService();
    }

    public function index()
    {
        return response()->json($this->service->getAllBillPtForAdmin());
    }

    public function getAllBillPtForPt()
    {
        return response()->json($this->service->getAllBillPtForPt());
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        return response()->json($this->service->createBillPt($request));
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
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
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
