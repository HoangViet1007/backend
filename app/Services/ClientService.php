<?php

namespace App\Services;


use App\Constants\StatusConstant;
use App\Exceptions\BadRequestException;
use App\Exceptions\SystemException;
use App\Models\Comment;
use App\Models\Course;
use App\Models\CourseStudent;
use App\Models\ModelHasRole;
use App\Models\Setting;
use App\Models\User;
use Exception;

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

    public function getPtHighlights()
    {

        $get_pt = User::with(['accountLevels'])
            ->join('model_has_roles', 'model_has_roles.user_id', 'users.id')
            ->where('model_has_roles.role_id', config('constant.role_pt'))
            ->orderBy('account_level_id', 'desc')->limit(config('constant.limit'))
            ->get();
        $get_pt->map(function ($item) {
            $item['count_course'] = Course::where('created_by', $item->id)->where('display', StatusConstant::ACTIVE)
                ->where('status', StatusConstant::HAPPENING)->count();

            return $item;
        });


        return $get_pt;
    }

    public function getCourse()
    {
        $get_course = Course::where('display', StatusConstant::ACTIVE)
            ->with(['customerLevel', 'teacher' => function ($query) {
                $query->select('name', 'id', 'image');
            }])->with(['specializeDetails.specialize' => function ($query) {

                $query->where('status', StatusConstant::ACTIVE);
            }])
            ->where('status', StatusConstant::HAPPENING)
            ->inRandomOrder()->limit(config('constant.limit'))->get();

        $get_course->map(function ($item) {
            $item['avg_start'] = Comment::where('status', StatusConstant::ACTIVE)->where('id_course', $item->id)
                ->avg('number_stars');
            $item['count_comment'] = Comment::where('status', StatusConstant::ACTIVE)->where('id_course', $item->id)
                ->count();
            $item['count_student'] = CourseStudent::where('status', StatusConstant::COMPLETE)
                ->where('course_id', $item->id)->count();

            return $item;
        });

        return $get_course;
    }

    public function getListPtClient()
    {
        try {
            $request = request()->all();
            $specializes = $request['specializes'] ?? null;
            $data = $this->queryHelper->removeParam('specializes')
                ->buildQuery(new User())
                ->join('model_has_roles', 'model_has_roles.user_id', 'users.id')
                ->join('roles', 'roles.id', 'model_has_roles.role_id')
                ->join('account_levels', 'account_levels.id', 'users.account_level_id')
                ->join('specialize_details', 'users.id',
                    'specialize_details.user_id')
                ->join('specializes', 'specializes.id',
                    'specialize_details.specialize_id')
                ->with('accountLevels', 'specializeDetails.specialize')
                ->where('roles.id', config('constant.role_pt'))
                ->where('users.status', StatusConstant::ACTIVE)
                ->when($specializes, function ($q) use ($specializes) {
                    $arraySpecialize = explode(',', $specializes) ?? [0];
                    $q->whereIn('specializes.id', $arraySpecialize);
                })
                ->select(['users.id', 'users.name', 'users.image', 'users.email', 'users.phone', 'users.address', 'users.description', 'users.sex', 'users.account_level_id'])
                ->distinct();

            return $data->paginate(10);
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function detailPT($id)
    {
        try {
            $detail_pt = User::where('id', $id)->where('status', StatusConstant::ACTIVE)->first();
            if ($detail_pt) {
                $detail_pt['count_course'] = Course::where('created_by', $detail_pt->id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->count();
                $array_course = Course::where('created_by', $detail_pt->id)->where('display', StatusConstant::ACTIVE)->where('status', StatusConstant::HAPPENING)->pluck('id')->toArray();
                $detail_pt['count_student'] = CourseStudent::whereNotIn('status',[StatusConstant::CANCELEDBYPT,StatusConstant::CANCELED])->whereIn('course_id', $array_course)->count();
                $detail_pt['course_related'] = $this->getCourses($id);

                return $detail_pt;
            } else {
                throw new BadRequestException(
                    ['message' => __("PT không tồn tại !")],
                    new \Exception()
                );
            }
        }catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }

    }

    public function getCourses($user_id)
    {
        $get_course = Course::where('display', StatusConstant::ACTIVE)
            ->where('created_by', $user_id)
            ->with(['customerLevel', 'teacher' => function ($query) {
                $query->select('name', 'id', 'image');
            }])->with(['specializeDetails.specialize' => function ($query) {
                $query->where('status', StatusConstant::ACTIVE);
            }])
            ->where('status', StatusConstant::HAPPENING)
            ->limit(config('constant.limit'))->get();;


        $get_course->map(function ($item) {
            $item['avg_start'] = Comment::where('status', StatusConstant::ACTIVE)->where('id_course', $item->id)->avg('number_stars');
            $item['count_comment'] = Comment::where('status', StatusConstant::ACTIVE)->where('id_course', $item->id)->count();
            $item['count_student'] = CourseStudent::where('status', StatusConstant::COMPLETE)->where('course_id', $item->id)->count();
            return $item;
        });

        return $get_course;
    }

    public function getSettingClient()
    {
        try {
            $data = Setting::where('status', StatusConstant::ACTIVE)->get();

            return $data;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }
}
