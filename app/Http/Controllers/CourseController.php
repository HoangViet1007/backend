<?php

namespace App\Http\Controllers;

use App\Services\BaseService;
use App\Services\CourseService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CourseController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new CourseService();
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

    public function getAllCourseCurrentPtNoPaginate(): JsonResponse
    {
        return response()->json($this->service->getAllCourseCurrentPtNoPaginate());
    }

    public function getCourseCurrentPt(): JsonResponse
    {
        return response()->json($this->service->getCourseCurrentPt());
    }

    // get all course in client
    public function getCourse(): JsonResponse
    {
        return response()->json($this->service->getCourse());
    }

    // get course plan off
    public function getCoursePlanOff(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->getCoursePlanOff($request, $id));
    }

    public function getCourseRequest(): JsonResponse
    {
        return response()->json($this->service->getCourseRequest());
    }

    /**
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
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    public function getCourseCurrentPtById($id): JsonResponse
    {
        return response()->json($this->service->getCourseCurrentPtById($id));
    }

    public function getCourseByIdInClient($id): JsonResponse
    {
        return response()->json(['detail_course'=>$this->service->getCourseByIdInClient($id),'get_course'=>$this->service->relatedCourses($id)]);
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

    public function updateCourseForAdmin(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->updateCourseForAdmin($id, $request));
    }

    public function updateDisplay(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->updateDisplay($request, $id));
    }

    public function requestCourse(Request $request, $id)
    {
        return response()->json($this->service->requestCourse($request, $id));
    }

    public function cancelRequestCourse(Request $request, $id)
    {
       return response()->json($this->service->cancelRequestCourse($request, $id));
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
