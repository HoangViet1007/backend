<?php

namespace App\Http\Controllers;

use App\Services\BaseService;
use App\Services\CoursePlaneService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CoursePlansController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new CoursePlaneService();
    }

    public function listCoursePlanes($id)
    {
        return response()->json($this->service->listCoursePlanes($id));

    }

    public function addCoursePlanes(Request $request): JsonResponse
    {
        return response()->json($this->service->add($request));

    }

    public function deleteCoursePlanes($id): JsonResponse
    {
        return response()->json($this->service->delete($id));

    }

    public function editCoursePlanes(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->update($id, $request));
    }

    public function detailCoursePlanes($id): JsonResponse
    {
        return response()->json(($this->service->get($id)));
    }

}
