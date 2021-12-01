<?php

namespace App\Services;

use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\BillPersonalTrainer;
use Illuminate\Support\Facades\Auth;


/**
 * @Author apple
 * @Date   Oct 01, 2021
 */
class BillPersonalTrainerService extends BaseService
{
    function createModel(): void
    {
        $this->model = new BillPersonalTrainer();
    }

    public function getAllBillPtForAdmin()
    {
        $this->preGetAll();
        $data = $this->queryHelper->buildQuery($this->model)->with('CourseStudent.courses', 'user', 'CourseStudent.users')
            ->join('users', 'bill_personal_trainers.user_id', 'users.id')
            ->join('course_students', 'bill_personal_trainers.course_student_id', 'course_students.id')
            ->join('courses', 'course_students.course_id', 'courses.id')
            ->select('bill_personal_trainers.*', 'users.name as userNamePt', 'courses.name as courseName');
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getAllBillPtForPt()
    {
        $userId = $this->currentUser()->id ?? null;
        $this->preGetAll();
        $data = $this->queryHelper->buildQuery($this->model)->with('CourseStudent.courses', 'user', 'CourseStudent.users')
            ->join('users', 'bill_personal_trainers.user_id', 'users.id')
            ->join('course_students', 'bill_personal_trainers.course_student_id', 'course_students.id')
            ->join('courses', 'course_students.course_id', 'courses.id')
            ->select('bill_personal_trainers.*', 'users.name as userNamePt', 'courses.name as courseName')
            ->where('bill_personal_trainers.user_id', $userId);
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function createBillPt(object $request)
    {
        $this->doValidate(
            $request,
            [
                'money' => 'required|numeric|min:0|max:50000000',
                'note' => 'max:255',
                'image' => 'required|max:255'
            ],
            [
                'money.required' => 'Không có số tiền !',
                'money.numeric' => 'Số tiền không hợp lệ !',
                'money.min' => 'Số tiền không hợp lệ',
                'money.max' => 'Số tiền quá lớn!',
                'note.max' => 'Ghi chú quá dài !',
                'image.required' => 'Ảnh giao dịch không được để trống !',
                'image.max' => 'Ảnh quá dài'
            ]
        );

        $arr = [
            'code_bill' => date("YmdHis") . Auth::id(),
            'time' => date('Y-m-d H:i:s'),
            'money' => $request->money,
            'note' => $request->note,
            'image' => $request->image,
            'course_student_id' => $request->course_student_id,
            'user_id' => $request->user_id
        ];
        $billPt = BillPersonalTrainer::create($arr);
        $billPtRel = BillPersonalTrainer::with('courseStudent.courses', 'user', 'courseStudent.users')->where('bill_personal_trainers.id', $billPt->id)->first();
        return $billPtRel;
    }

}
