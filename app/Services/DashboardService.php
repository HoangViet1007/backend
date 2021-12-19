<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Models\AccountLevel;
use App\Models\Bill;
use App\Models\BillPersonalTrainer;
use App\Models\Course;
use App\Models\CourseStudent;
use App\Models\Demo;
use App\Models\ModelHasRole;
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

    public function validatedashboardAdmin($request)
    {
        $year = Carbon::now()->addYear()->year;
        $this->doValidate($request, [
            'year_turnover' => 'numeric|min:2020|max:' . $year,
            'year_profit' => 'numeric|min:2020|max:' . $year,
        ], [
            'year_turnover.min' => 'Năm không hợp lệ!',
            'year_turnover.max' => 'Năm không hợp lệ!',
            'year_turnover.numeric' => 'Năm không đúng định dạng !',
            'year_profit.min' => 'Năm không hợp lệ!',
            'year_profit.max' => 'Năm không hợp lệ!',
            'year_profit.numeric' => 'Năm không đúng định dạng !',

        ]);
    }


    public function dashboardAdmin($request)
    {
        $this->validatedashboardAdmin($request);

        $count_pt = ModelHasRole::where('role_id', config('constant.role_pt'))->count();


        $count_customer = ModelHasRole::where('role_id', config('constant.role_customer'))->count();

        $count_staff = ModelHasRole::whereNotIn('role_id', [config('constant.role_pt'), config('constant.role_customer')])->count();
        $count_payment_pt = CourseStudent::where('status', StatusConstant::REQUESTADMIN)->count();
        $account_level = AccountLevel::count();
        $count_complain = Schedule::where('complain', StatusConstant::COMPLAIN)->count();
        $count_course = Course::where('display', StatusConstant::ACTIVE)->count();
        // tinh doanh thu theo thang
        $month = Carbon::now()->month;
        $year_turnover = $request->year_turnover ?? Carbon::now()->year;
        $year_profit = $request->year_profit ?? Carbon::now()->year;
// sum money nap vao website
        $sum_revenue_month = Payment::whereMonth('created_at', $month)->where('note', StatusConstant::RECHARGE)->sum('money');

// sum money nap vao website

        $sum_total_in_month = Payment::where('note', StatusConstant::RECHARGE)
            ->whereYear('created_at', $year_turnover)
            ->selectRaw('year(created_at) year, monthname(created_at) month, sum(money) sum_total_in_month')
            ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
            ->get();


        // doanh thu
        $sum_revenue_website = BillPersonalTrainer::selectRaw('year(created_at) year, monthname(created_at) month, sum(money_old) - sum(money) sum_total_in_website')
            ->whereYear('created_at', $year_profit)
            ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
            ->get();
        // doanh thu

        $sum_revenue_month_website = BillPersonalTrainer::whereMonth('created_at', $month)
            ->whereYear('created_at', $year_profit)
            ->selectRaw('sum(money_old) - sum(money) sum_total_in_month_website')
            ->whereMonth('created_at', $month)
            ->get();


        $count_specializes = Specialize::where('status', StatusConstant::ACTIVE)->count();

        $month_in_year = [
            'January' => 0,
            'February' => 0,
            'March' => 0,
            'April' => 0,
            'May' => 0,
            'June' => 0,
            'July' => 0,
            'August' => 0,
            'September' => 0,
            'October' => 0,
            'November' => 0,
            'December' => 0

        ];


        $sum_total_month_in_year = [
            'January' => 0,
            'February' => 0,
            'March' => 0,
            'April' => 0,
            'May' => 0,
            'June' => 0,
            'July' => 0,
            'August' => 0,
            'September' => 0,
            'October' => 0,
            'November' => 0,
            'December' => 0

        ];
        $sum_revenue_website_year = 0;
        foreach ($sum_revenue_website as $value_new) {
            foreach ($month_in_year as $key => $value) {
                if ($key == $value_new->month) {
                    $month_in_year[$key] = $value_new->sum_total_in_website ?? 0;
                    $sum_revenue_website_year += $value_new->sum_total_in_website;
                }
            }
        }
        $sum_total_year = 0;
        foreach ($sum_total_in_month as $value_new) {
            foreach ($sum_total_month_in_year as $key => $value) {
                if ($key == $value_new->month) {
                    $sum_total_month_in_year[$key] = $value_new->sum_total_in_month ?? 0;
                    $sum_total_year += $value_new->sum_total_in_month;
                }
            }
        }

        $data = [
            'count_pt' => $count_pt,
            'count_customer' => $count_customer,
            'count_staff' => $count_staff,
            'count_course' => $count_course,
            'sum_revenue_month' => $sum_revenue_month,
            'count_specializes' => $count_specializes,
            'count_payment_pt' => $count_payment_pt,
            'account_level' => $account_level,
            'sum_total_year' => $sum_total_year,
            'count_complain' => $count_complain,
            'sum_revenue_website_year' => $sum_revenue_website_year,
            'sum_revenue_month_website' => $sum_revenue_month_website,
            'sum_total_in_month' => $sum_total_month_in_year,
            'sum_revenue_website' => $month_in_year,

        ];

        return $data;

    }


    public function validatedashboardPT($request)
    {
        $year = Carbon::now()->addYear()->year;
        $this->doValidate($request, [
            'year_count_student' => 'numeric|min:2020|max:' . $year,
            'year_sum_money' => 'numeric|min:2020|max:' . $year,

        ], [
            'year_count_student.min' => 'Năm không hợp lệ!',
            'year_count_student.max' => 'Năm không hợp lệ!',
            'year_count_student.numeric' => 'Năm không đúng định dạng !',
            'year_sum_money.min' => 'Năm không hợp lệ!',
            'year_sum_money.max' => 'Năm không hợp lệ!',
            'year_sum_money.numeric' => 'Năm không đúng định dạng !',

        ]);
    }


    public function dashboardPT($request)
    {
        $year_sum_money = $request->year_sum_money ?? Carbon::now()->year;
        $year_count_student = $request->year_count_student ?? Carbon::now()->year;

        $this->validatedashboardPT($request);
        $id = Auth::user()->id;
        $date_now = Carbon::now();
        $month = $date_now->month;

        $count_course = Course::where('created_by', $id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->count();
        $array_id_course = Course::where('created_by', $id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->pluck('id');
        $count_student = 0;
        if (count($array_id_course) > 0) {
            $count_student = CourseStudent::where('status', StatusConstant::SCHEDULE, StatusConstant::COMPLETE)
                ->whereIn('course_id', $array_id_course)
                ->count();

            $count_student_month_in_year = CourseStudent::where('status', StatusConstant::SCHEDULE, StatusConstant::COMPLETE)
                ->whereMonth('created_at', $month)
                ->whereYear('created_at', $year_count_student)
                ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
                ->whereIn('course_id', $array_id_course)
                ->selectRaw('year(created_at) year, monthname(created_at) month, COUNT(id) as sum_student_in_month')
                ->get();


            $count_student_month = CourseStudent::where('status', StatusConstant::SCHEDULE, StatusConstant::COMPLETE)
                ->whereMonth('created_at', $month)
                ->whereYear('created_at', $year_count_student)
                ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
                ->whereIn('course_id', $array_id_course)
                ->selectRaw('year(created_at) year, monthname(created_at) month, COUNT(id) as sum_student_in_month')->count();

        }

        $sum_money_month = BillPersonalTrainer::where('user_id', $id)
            ->whereMonth('created_at', $month)
            ->whereYear('created_at', $year_sum_money)
            ->groupBy(DB::raw('MONTH(created_at)'))->sum('money');


        $sum_total_in_month = BillPersonalTrainer::where('user_id', $id)
            ->whereYear('created_at', $year_sum_money)
            ->selectRaw('year(created_at) year, monthname(created_at) month, sum(money) sum_total_in_month')
            ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
            ->get();
        $count_specialize = SpecializeDetail::where('user_id', $id)->count();

        $month_in_year = [
            'January' => 0,
            'February' => 0,
            'March' => 0,
            'April' => 0,
            'May' => 0,
            'June' => 0,
            'July' => 0,
            'August' => 0,
            'September' => 0,
            'October' => 0,
            'November' => 0,
            'December' => 0
        ];
        $sum_total_year = 0;
        foreach ($sum_total_in_month as $value_new) {
            foreach ($month_in_year as $key => $value) {
                if ($key == $value_new->month) {
                    $month_in_year[$key] = $value_new->sum_total_in_month ?? 0;
                    $sum_total_year += $value_new->sum_total_in_month;
                }
            }
        }

        $count_student_year = 0;

        if (count($count_student_month_in_year) > 0) {
            $count_student_month_in_years = [
                'January' => 0,
                'February' => 0,
                'March' => 0,
                'April' => 0,
                'May' => 0,
                'June' => 0,
                'July' => 0,
                'August' => 0,
                'September' => 0,
                'October' => 0,
                'November' => 0,
                'December' => 0
            ];

            foreach ($count_student_month_in_year as $value_new) {
                foreach ($count_student_month_in_years as $key => $value) {
                    if ($key == $value_new->month) {
                        $count_student_month_in_years[$key] = $value_new->sum_student_in_month ?? 0;
                        $count_student_year += $value_new->sum_student_in_month;
                    }
                }
            }
        }

        $data['count_course'] = $count_course;
        $data['count_student'] = $count_student;
        $data['count_specialize'] = $count_specialize;
        $data['sum_money_month'] = $sum_money_month;
        $data['sum_total_year'] = $sum_total_year;
        $data['count_student_month'] = $count_student_month;
        $data['sum_total_in_month'] = $month_in_year;
        $data['count_student_month_in_year'] = $count_student_month_in_years;
        $data['count_student_year'] = $count_student_year;

        return $data;

    }


    public function validatedashboardCustomer($request)
    {
        $year = Carbon::now()->addYear()->year;
        $this->doValidate($request, [
            'year_loaded_money' => 'numeric|min:2020|max:' . $year,
            'year_money_spent' => 'numeric|min:2020|max:' . $year,

        ], [
            'year_loaded_money.min' => 'Năm không hợp lệ!',
            'year_loaded_money.max' => 'Năm không hợp lệ!',
            'year_loaded_money.numeric' => 'Năm không đúng định dạng !',
            'year_money_spent.min' => 'Năm không hợp lệ!',
            'year_money_spent.max' => 'Năm không hợp lệ!',
            'year_money_spent.numeric' => 'Năm không đúng định dạng !',
        ]);
    }

    public function dashboardCustomer($request)
    {
        $this->validatedashboardCustomer($request);
        $year_money_spent = $request->year_money_spent ?? Carbon::now()->year;
        $year_loaded_money = $request->year_loaded_money ?? Carbon::now()->year;
        $date_now = Carbon::now();
        $month = $date_now->month;
        $id = Auth::user()->id;

        $count_course = CourseStudent::where('user_id', $id)->count();
        $sum_money_spent_month = Bill::where('user_id', $id)
            ->whereMonth('created_at', $month)
            ->whereYear('created_at', $year_money_spent)
            ->sum('money');
        $sum_money_spent_month_in_years = Bill::where('user_id', $id)
            ->whereYear('created_at', $year_money_spent)
            ->selectRaw('year(created_at) year, monthname(created_at) month, sum(money) sum_total_in_website')
            ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
            ->get();

        // naapj vao website
        $sum_money_loaded_money_month = Payment::where('user_id', $id)
            ->whereYear('created_at', $year_loaded_money)
            ->whereMonth('created_at', $month)->sum('money');
        $sum_money_loaded_money_month_in_years = Payment::where('user_id', $id)
            ->whereYear('created_at', $year_loaded_money)
            ->selectRaw('year(created_at) year, monthname(created_at) month, sum(money) sum_total_in_website')
            ->groupBy(DB::raw('YEAR(created_at)'), DB::raw('MONTH(created_at)'))
            ->get();


        $sum_money_spent_month_in_year = [
            'January' => 0,
            'February' => 0,
            'March' => 0,
            'April' => 0,
            'May' => 0,
            'June' => 0,
            'July' => 0,
            'August' => 0,
            'September' => 0,
            'October' => 0,
            'November' => 0,
            'December' => 0

        ];
        $money_spent_years = 0;
        foreach ($sum_money_spent_month_in_years as $value_new) {
            foreach ($sum_money_spent_month_in_year as $key => $value) {
                if ($key == $value_new->month) {
                    $sum_money_spent_month_in_year[$key] = $value_new->sum_total_in_website ?? 0;
                    $money_spent_years = $value_new->sum_total_in_website;
                }
            }
        }

        $sum_money_loaded_money_month_in_year = [
            'January' => 0,
            'February' => 0,
            'March' => 0,
            'April' => 0,
            'May' => 0,
            'June' => 0,
            'July' => 0,
            'August' => 0,
            'September' => 0,
            'October' => 0,
            'November' => 0,
            'December' => 0

        ];
        $money_loaded_years = 0;
        foreach ($sum_money_loaded_money_month_in_years as $value_new) {
            foreach ($sum_money_loaded_money_month_in_year as $key => $value) {
                if ($key == $value_new->month) {
                    $sum_money_loaded_money_month_in_year[$key] = $value_new->sum_total_in_website ?? 0;
                    $money_loaded_years = $value_new->sum_total_in_website;
                }
            }
        }

        $data['count_course'] = $count_course;
        $data['money_spent_years'] = $money_spent_years;
        $data['sum_money_spent_month'] = $sum_money_spent_month;
        $data['sum_money_spent_month_in_year'] = $sum_money_spent_month_in_year;
        $data['money_loaded_years'] = $money_loaded_years;
        $data['sum_money_loaded_money_month'] = $sum_money_loaded_money_month;
        $data['sum_money_loaded_money_month_in_year'] = $sum_money_loaded_money_month_in_year;

        return $data;
    }
}
