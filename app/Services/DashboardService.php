<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Models\BillPersonalTrainer;
use App\Models\Course;
use App\Models\CourseStudent;
use App\Models\Demo;
use App\Models\Payment;
use App\Models\Schedule;
use App\Models\Specialize;
use App\Models\SpecializeDetail;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

/**
 * @Author apple
 * @Date   Sep 27, 2021
 */
class DashboardService extends BaseService
{

    function createModel(): void
    {
        $this->model = new Demo();
    }


    public function dashboardAdmin()
    {
        $count_pt_active = User::where('status', StatusConstant::ACTIVE)->with([
                'modelHasRoles' => function ($query) {
                    $query->where('role_id', config('constant.role_pt'));
                }]
        )->count();

        $count_pt_inactive = User::where('status', StatusConstant::INACTIVE)->with([
                'modelHasRoles' => function ($query) {
                    $query->where('role_id', config('constant.role_pt'));
                }]
        )->count();

        $count_user_active = User::where('status', StatusConstant::ACTIVE)->with([
                'modelHasRoles' => function ($query) {
                    $query->where('role_id', config('constant.role_customer'));
                }]
        )->count();

        $count_user_inactive = User::where('status', StatusConstant::INACTIVE)->with([
                'modelHasRoles' => function ($query) {
                    $query->where('role_id', config('constant.role_customer'));
                }]
        )->count();

        $count_course = Course::where('status', StatusConstant::HAPPENING)->where('display', StatusConstant::ACTIVE)->count();
        // tinh doanh thu theo thang
        $month = Carbon::now()->month;

        $sum_revenue_month = Payment::whereMonth('created_at', $month)->where('note', StatusConstant::RECHARGE)->sum('money');


        $sum_total_in_month = Payment::where('note', StatusConstant::RECHARGE)
            ->selectRaw('year(created_at) year, monthname(created_at) month, sum(money_old) - sum(money) sum_total_in_month')
            ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
            ->get();

        $sum_revenue_website = BillPersonalTrainer::selectRaw('year(created_at) year, monthname(created_at) month, sum(money) - sum(money_old) sum_total_in_website')
            ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
            ->get();

        $sum_revenue_month_website = BillPersonalTrainer::whereMonth('created_at', $month)
            ->selectRaw('sum(money_old) - sum(money) sum_total_in_month_website')
            ->whereMonth('created_at', $month)
            ->get();
        $count_specializes = Specialize::where('status', StatusConstant::ACTIVE)->count();
        $data = [
            'count_pt_active' => $count_pt_active,
            'count_pt_inactive' => $count_pt_inactive,
            'count_user_active' => $count_user_active,
            'count_user_inactive' => $count_user_inactive,
            'count_course' => $count_course,
            'sum_revenue_month' => $sum_revenue_month,
            'sum_total_in_month' => $sum_total_in_month,
            'sum_revenue_website' => $sum_revenue_website,
            'sum_revenue_month_website' => $sum_revenue_month_website,
            'count_specializes' => $count_specializes
        ];

        return $data;

    }

    public function dashboardPT()
    {
        $id = Auth::user()->id;
        $month = Carbon::now()->month;

        $count_course = Course::where('created_by', $id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->count();
        $array_id_course = Course::where('created_by', $id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->pluck('id');
        $count_student = 0;
        if (count($array_id_course) > 0) {
            $count_student = CourseStudent::where('status', StatusConstant::COMPLETE)->whereIn('course_id', $array_id_course)->count();
            $count_student_month = CourseStudent::where('status', StatusConstant::COMPLETE)
                ->whereMonth('created_at', $month)
                ->whereIn('course_id', $array_id_course)->count();
        }

        $sum_money_month = BillPersonalTrainer::where('user_id', $id)
            ->whereMonth('created_at', $month)
            ->groupBy(DB::raw('MONTH(created_at)'))->sum('money');

        $sum_total_in_month = BillPersonalTrainer::where('user_id', $id)
            ->selectRaw('year(created_at) year, month(created_at) month, sum(money) sum_total_in_month')
            ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
            ->get();
        $count_specialize = SpecializeDetail::where('user_id', $id)->count();
        $data['count_course'] = $count_course;
        $data['count_student'] = $count_student;
        $data['count_specialize'] = $count_specialize;
        $data['sum_money_month'] = $sum_money_month;
        $data['count_student_month'] = $count_student_month;
        $data['sum_total_in_month'] = $sum_total_in_month;

        return $data;

    }

    public function dashboardCustomer()
    {

    }
}
