<?php

namespace App\Http\Controllers;

use App\Models\CourseStudent;
use App\Services\BaseService;
use App\Services\ScheduleService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ScheduleController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new ScheduleService();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(): JsonResponse
    {
        //
    }

    // lay za schedule trong pt (all)
    public function getScheduleByCourseStudent(Request $request, $id)
    {
        return response()->json($this->service->getScheduleByCourseStudent($request, $id));
    }

    // get schedule by customer
    public function getScheduleByCustomer(Request $request, $id): JsonResponse
    {
        /* check course_student truyen len co phai cua no hay ko
         * */
        $course_student = CourseStudent::find($id);
        $user_id        = $course_student->user_id;

        return response()->json($this->service->getScheduleByCourseStudent($request, $id, $user_id));
    }

    public function getCalenderCustomer(Request $request): JsonResponse
    {
        return response()->json($this->service->getCalenderCustomer($request));
    }

    public function getCalenderPt(Request $request): JsonResponse
    {
        return response()->json($this->service->getCalenderPt($request));
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
        return response()->json($this->service->update($id, $request));
    }

    // update status chedule complete
    public function updateStatusScheduleComplete($id, Request $request): JsonResponse
    {
        return response()->json($this->service->updateStatusScheduleComplete($id, $request));
    }

    public function notEngaged($id, Request $request): JsonResponse
    {
        return response()->json($this->service->notEngaged($id, $request));
    }

    public function engaged($id, Request $request): JsonResponse
    {
        return response()->json($this->service->engaged($id, $request));
    }

    // khieu nai
    public function complanin($id, Request $request)
    {
        return response()->json($this->service->complanin($id, $request));
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
        return response()->json($this->service->delete($id));
    }
}
