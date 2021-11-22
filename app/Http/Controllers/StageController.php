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
        return response()->json(($this->service->get($id)));
    }

// test send email
    public function sendEmail()
    {
        Mail::to('ngohongnguyen016774@gmail.com')->send(new TetSendMailNotify());
        return env('MAIL_USERNAME');
    }

    // send email lịch học cho học viên
// thành công
    public function sendEmailStudent()
    {
        $email = 'ngohongnguyen016774@gmail.com';
        $name_student = 'Ngô Hồng Nguyên';
        $name_couser = 'Khóa học giảm mỡ cho người béo phì';
        $time_hour = '14 h';
        $name_pt = 'Chúc Anh Quân';
        $phone_pt = '0828890896';
        $link_room = 'link phòng room';
        $date_study = "22/11/2021";
        return Mail::to($email)->send(new ScheduleCourse($name_student, $date_study, $name_couser, $time_hour, $name_pt, $phone_pt, $link_room));

    }
    // send email hủy khóa học của học viên
    // thành công
    public function sendEmailCancelStudent()
    {
        $email = 'ngohongnguyen016774@gmail.com';
        $name_student = 'Ngô Hồng Nguyên';
        $name_couser = 'Khóa học giảm mỡ cho người béo phì';
        $price = 40000000;
        return Mail::to($email)->send(new CancelCourse($name_student, $name_couser, $price));

    }

    // send email Pt không thể dạy được buổi học hôm nay
    // thành công
    public function ptCantTeach()
    {
        $email = 'ngohongnguyen016774@gmail.com';
        $student_name = 'Ngô Hồng Nguyên';
        $name_couser = 'Khóa học giảm mỡ cho người béo phì';
        $time_hour = '14 h';
        $time_study = '22/10/2021';
        return Mail::to($email)->send(new PTCantTeach($student_name, $time_study, $name_couser, $time_hour));

    }

// học viên hủy buổi học
// thành công
    public function CustormCancel()
    {
        $email = 'ngohongnguyen016774@gmail.com';
        $student_name = 'Ngô Hồng Nguyên';
        $teach_name = 'Ngô Hồng Nguyên';
        $name_couser = 'Khóa học giảm mỡ cho người béo phì';
        $time_hour = '14 h';
        $time_study = '22/10/2021';
        $reason = 'Lý do nghỉ';
        return Mail::to($email)->send(new CustormCancel($teach_name, $student_name, $time_hour, $time_study, $reason, $name_couser));

    }

    // pt duyệt khóa học
// thành công
    public function SuccessfulCourseBrowsing()
    {
        $email = 'ngohongnguyen016774@gmail.com';
        $name_student = 'Chúc Anh Quân';
        $name_pt = 'Ngô Hồng Nguyên';
        $name_course = 'Khóa học đỡ nói phét';
        $price = 4000000;
        return Mail::to($email)->send(new SuccessfulCourseBrowsing($name_student, $name_course, $price, $name_pt));

    }

}
