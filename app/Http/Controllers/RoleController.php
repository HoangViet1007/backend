<?php

namespace App\Http\Controllers;

use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Exceptions\ForbiddenException;
use App\Services\BaseService;
use App\Services\RoleService;
use App\Trait\RoleAndPermissionTrait;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class RoleController extends Controller
{
    public BaseService $service;

    use RoleAndPermissionTrait;
    public function __construct()
    {
        $this->service = new RoleService();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(): JsonResponse
    {
        if (!$this->hasPermission(PermissionConstant::role(ActionConstant::LIST)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->getAll());
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
    public function store(Request $request): JsonResponse
    {
        if (!$this->hasPermission(PermissionConstant::role(ActionConstant::ADD)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->add($request));
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     *
     * @return \Illuminate\Http\Response
     */
    public function show($id): JsonResponse
    {
        return response()->json($this->service->getById($id));
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
    public function update(Request $request, $id): JsonResponse
    {
        if (!$this->hasPermission(PermissionConstant::role(ActionConstant::EDIT)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->update($id, $request));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     *
     * @return \Illuminate\Http\Response
     */
    public function destroy($id): JsonResponse
    {
        if (!$this->hasPermission(PermissionConstant::role(ActionConstant::DELETE)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->delete($id));
    }
}
