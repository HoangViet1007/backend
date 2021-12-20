<?php

namespace App\Http\Controllers;

use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Exceptions\ForbiddenException;
use App\Exports\ExportPermission;
use App\Imports\ImportPermission;
use App\Services\BaseService;
use App\Services\PermissionService;
use App\Trait\RoleAndPermissionTrait;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

class PermissionController extends Controller
{
    public BaseService $service;

    use RoleAndPermissionTrait;
    public function __construct()
    {
        $this->service = new PermissionService();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(): JsonResponse
    {
        return response()->json($this->service->getAllPermission());
    }

    public function getAllPermission(): JsonResponse
    {
        if (!$this->hasPermission(PermissionConstant::permission(ActionConstant::LIST)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->getAllPermission2());
    }

    public function getAllPermissionNoPaginate(): JsonResponse
    {
        return response()->json($this->service->getAllPermissionNoPaginate());
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
        if (!$this->hasPermission(PermissionConstant::permission(ActionConstant::ADD)))
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
        return response()->json($this->service->get($id));
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
        if (!$this->hasPermission(PermissionConstant::permission(ActionConstant::EDIT)))
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
        if (!$this->hasPermission(PermissionConstant::permission(ActionConstant::DELETE)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return response()->json($this->service->delete($id));
    }

    public function import(Request $request)
    {
        if (!$this->hasPermission(PermissionConstant::permission(ActionConstant::IMPORT)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        $permissionService = new PermissionService();
        $permissionService->doValidate($request,
                                       [
                                           'file' => 'required|mimes:xls,xlsx'
                                       ],
                                       [
                                           'file.required' => "Hãy nhập file excel để import quyền !",
                                           'file.mimes'    => "Hãy nhập đúng định dạng file excel !",
                                       ]
        );

        $file = $request->file('file');
        Excel::import(new ImportPermission(), $file);

        return true;
    }

    public function export()
    {
        if (!$this->hasPermission(PermissionConstant::permission(ActionConstant::EXPORT)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        return Excel::download(new ExportPermission(), 'Template_permission.xlsx');
    }
}
