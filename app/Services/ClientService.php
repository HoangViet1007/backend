<?php

namespace App\Services;


use App\Constants\StatusConstant;
use App\Models\Course;
use App\Models\ModelHasRole;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use App\Models\Contact;

/**
 * @Author apple
 * @Date   Sep 30, 2021
 */
class ClientService extends BaseService
{

    public $arrayStatusChedule = [StatusConstant::UNFINISHED, StatusConstant::COMPLETE];

    function createModel(): void
    {
        $this->model = new Contact();
    }

    /**
     *
     * @return \Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */

    public function get_pt_highlights()
    {

        $get_pt = User::with(['modelHasRoles' => function ($query) {
            $query->where('role_id', 3);
        }])->orderBy('account_level_id', 'desc')->limit(10)->get();

        return $get_pt;
    }

    public function get_course()
    {
        $get_course = Course::where('display', StatusConstant::ACTIVE)->where('status' , StatusConstant::HAPPENING)->inRandomOrder()->limit(10)->get();

        return $get_course;
    }

    public function list_pt($request){

    }
}
