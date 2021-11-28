<?php

namespace App\Services;

use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Bill;

class BillService extends BaseService
{
    function createModel(): void
    {
        $this->model = new Bill();
    }

    public function getBillByAdmin()
    {
        $this->preGetAll();
        $data = $this->queryHelper->buildQuery($this->model)->with('course', 'user')
            ->join('courses', 'courses.id', 'bills.course_id')
            ->join('users', 'users.id', 'bills.user_id')
            ->select('bills.*', 'courses.name', 'users.name as userName');
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getBillByCustomer()
    {
        $this->preGetAll();
        $id = $this->currentUser()->id ?? null;
        $data = $this->queryHelper->buildQuery($this->model)->with('course', 'user')
            ->join('courses', 'courses.id', 'bills.course_id')
            ->select('bills.*', 'courses.name')
            ->where('user_id', $id);
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

}
