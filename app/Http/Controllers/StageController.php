<?php

namespace App\Http\Controllers;

use App\Mail\CustormCancel;
use App\Mail\PTCantTeach;
use App\Mail\SuccessfulCourseBrowsing;
use Illuminate\Support\Facades\Mail;
use App\Services\BaseService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Services\StageService;
use App\Mail\TetSendMailNotify;
use App\Mail\ScheduleCourse;
use App\Mail\CancelCourse;

class StageController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new StageService();
    }

    public function listStage($id)
    {
        return response()->json($this->service->listStage($id));

    }

    public function addStage(Request $request): JsonResponse
    {
        return response()->json($this->service->add($request));

    }

    /**
     * edit stage
     */
    public function editStage(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->update($id, $request));
    }

    /**
     * Xóa stage
     */

    public function deleteStage($id): JsonResponse
    {
        return response()->json($this->service->delete($id));

    }

    public function detailStage($id): JsonResponse
    {
        return response()->json(($this->service->detailStage($id)));
    }



}
