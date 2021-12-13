<?php

namespace App\Http\Controllers;

use App\Exceptions\SystemException;
use Illuminate\Http\Request;
use App\Services\BaseService;
use App\Services\PaymentService;

class PaymentController extends Controller
{

    public BaseService $service;

    public function __construct()
    {
        $this->service = new PaymentService();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json($this->service->getPaymentByAdmin());
    }

    public function listPaymentByCustomer()
    {
        return response()->json($this->service->getPaymentByCustomer());
    }

    public function createPayment(Request $request)
    {
        return $this->service->createPayment($request);
    }

    public function returnPayment(Request $request)
    {
        return response()->json($this->service->returnPayment($request));
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
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
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
