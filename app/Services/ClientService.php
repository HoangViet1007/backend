<?php

namespace App\Services;


use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Models\Comment;
use App\Models\Course;
use App\Models\CourseStudent;
use App\Models\Schedule;
use App\Models\User;

/**
 * @Author apple
 * @Date   Sep 30, 2021
 */
class ClientService extends BaseService
{

    public $arrayStatusChedule = [StatusConstant::UNFINISHED, StatusConstant::COMPLETE];

    function createModel(): void
    {
        $this->model = new User();
    }

    /**
     *
     * @return \Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */

    public function get_pt_highlights()
    {

        $get_pt = User::with(['accountLevels', 'modelHasRoles' => function ($query) {
            $query->where('role_id', 3);
        }
        ])->orderBy('account_level_id', 'desc')->limit(config('constant.limit'))
            ->get();
        $get_pt->map(function ($item) {
            $item['count_course'] = Course::where('created_by', $item->id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->count();
            return $item;
        });

        return $get_pt;
    }

    public function get_course()
    {
        $get_course = Course::where('display', StatusConstant::ACTIVE)
            ->with(['teacher' => function ($query) {
                $query->select('name', 'id', 'image');
            }])->with(['specializeDetails.specialize' => function ($query) {
                $query->where('status', StatusConstant::ACTIVE);
            }])
            ->where('status', StatusConstant::HAPPENING)
            ->inRandomOrder()->limit(config('constant.limit'))->get();


        $get_course->map(function ($item) {
            $item['avg_start'] = Comment::where('status', StatusConstant::ACTIVE)->where('id_course', $item->id)->avg('number_stars');
            $item['count_comment'] = Comment::where('status', StatusConstant::ACTIVE)->where('id_course', $item->id)->count();
            $item['count_student'] = CourseStudent::where('status', StatusConstant::COMPLETE)->where('course_id', $item->id)->count();
            return $item;
        });

        return $get_course;
    }

    public function detailPT($id)
    {
        $detail_pt = User::where('id', $id)->where('status', StatusConstant::ACTIVE)->first();
        if ($detail_pt) {
            $detail_pt['count_course'] = Course::where('created_by', $detail_pt->id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->count();
            $array_course = Course::where('created_by', $detail_pt->id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->pluck('id')->toArray();
            if(count($array_course)>0){
                $detail_pt['count_student'] = CourseStudent::where('status', StatusConstant::COMPLETE)->whereIn('course_id', $array_course)->count();
            }
            return $detail_pt;
        } else {
            throw new BadRequestException(
                ['message' => __("PT không tồn tại !")],
                new \Exception()
            );
        }
    }
}
