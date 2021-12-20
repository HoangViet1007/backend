<?php

namespace App\Http\Controllers;

use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Exceptions\ForbiddenException;
use App\Services\BaseService;
use App\Services\SettingService;
use App\Trait\RoleAndPermissionTrait;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    public BaseService $service;

    use RoleAndPermissionTrait;
    public function __construct()
    {
        $this->service = new SettingService();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(): JsonResponse
    {
        if (!$this->hasPermission(PermissionConstant::setting(ActionConstant::LIST)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->getAll());
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
        if (!$this->hasPermission(PermissionConstant::setting(ActionConstant::ADD)))
            throw new ForbiddenException(__('Access denied'), new Exception());

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
        if (!$this->hasPermission(PermissionConstant::setting(ActionConstant::EDIT)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->update($id,$request));
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
        if (!$this->hasPermission(PermissionConstant::setting(ActionConstant::DELETE)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->delete($id));
    }
}
