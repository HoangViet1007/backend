<?php

namespace App\Services;

use App\Exceptions\BadRequestException;
use App\Exceptions\NotFoundException;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Course;
use App\Models\SpecializeDetail;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use App\Models\Certificate;

/**
 * @Author apple
 * @Date   Oct 01, 2021
 */
class SpecializeDetailService extends BaseService
{
    function createModel(): void
    {
        $this->model = new SpecializeDetail();
    }

    public function getDetailByAdmin(int|string $id): Model
    {
        $this->preGet($id);
        try {
            if ($this->queryHelper->relations)
                $this->model = $this->model->with($this->queryHelper->relations);

            $entity = $this->model->with('specialize')
                ->join('specializes', 'specialize_details.specialize_id', 'specializes.id')
                ->select('specialize_details.*', 'specializes.name')
                ->findOrFail($id);
            $this->postGet($id, $entity);

            return $entity;
        } catch (ModelNotFoundException $e) {
            throw new NotFoundException(
                ['message' => __("not-exist", ['attribute' => __('entity')]) . ": $id"],
                $e
            );
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getDetailByPt(int|string $id): Model
    {
        $userId = $this->currentUser()->id ?? null;
        $specializeByUser = SpecializeDetail::where('user_id', '=', $userId)->where('id', '=', $id)->first();
        if (!$specializeByUser) {
            throw new BadRequestException(
                ['message' => 'Không có chuyên môn nào theo yêu cầu !'], new Exception()
            );
        }
        parent::preDelete($id);
        try {
            if ($this->queryHelper->relations)
                $this->model = $this->model->with($this->queryHelper->relations);

            $entity = $this->model->with('specialize')
                ->join('specializes', 'specialize_details.specialize_id', 'specializes.id')
                ->select('specialize_details.*', 'specializes.name')
                ->findOrFail($id);
            $this->postGet($id, $entity);

            return $entity;
        } catch (ModelNotFoundException $e) {
            throw new NotFoundException(
                ['message' => __("not-exist", ['attribute' => __('entity')]) . ": $id"],
                $e
            );
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getAllByPt(): LengthAwarePaginator
    {
        $this->preGetAll();
        $id = $this->currentUser()->id ?? null;
        $data = $this->queryHelper->buildQuery($this->model)->with('specialize', 'certificates', 'courses')
            ->join('specializes', 'specialize_details.specialize_id', 'specializes.id')
            ->select('specialize_details.*', 'specializes.name')
            ->where('user_id', $id);
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getAllUseSelectOption()
    {
        $this->preGetAll();
        $id = $this->currentUser()->id ?? null;
        $data = $this->queryHelper->buildQuery($this->model)->with('specialize', 'certificates', 'courses')->where('user_id', $id);
        try {
            $response = $data->get();
            $this->postGetAll($response);
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function getAllByAdmin(): LengthAwarePaginator
    {
        $this->preGetAll();
        $data = $this->queryHelper->buildQuery($this->model)->with('specialize', 'certificates', 'courses')
            ->join('specializes', 'specialize_details.specialize_id', 'specializes.id')
            ->select('specialize_details.*', 'specializes.name');
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }


    public function deleteByAdmin(int|string $id): bool
    {
        DB::beginTransaction();
        $dataChildren = Certificate::where('specialize_detail_id', $id)->count();
        $dataChildrenCource = Course::where('specialize_detail_id', $id)->count();
        if ($dataChildren > 0 || $dataChildrenCource > 0) {
            throw new BadRequestException(
                ['message' => 'Xóa không thành công !'], new Exception()
            );
        }
        $data = $this->get($id);
        try {
            $deleted = $data->delete();
            DB::commit();
            return $deleted;
        } catch (Exception $e) {
            DB::rollBack();
            throw new SystemException(
                ['message' => __('can-not-del', ['attribute' => __('entity')]) . ": $id"],
                $e
            );
        }
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules = [
            'experience' => 'required|numeric',
            'specialize_id' =>
                [
                    'required',
                    'exists:specializes,id',
                    Rule::unique('specialize_details',)->where(function ($query) {
                        return $query->where('user_id', '=', $this->currentUser()->id);
                    }),
                ]
            ,
            'user_id' => 'required|exists:users,id'
        ];
        $messages = [
            'experience.required' => 'Năm kinh nghiệm không được để trống !',
            'experience.numeric' => 'Năm kinh nghiệm không hợp lệ !',
            'specialize_id.required' => 'Chuyên môn không được để trống !',
            'specialize_id.exists' => 'Chuyên môn không tồn tại !',
            'specialize_id.unique' => 'Chuyên môn đã tồn tại !',
            'user_id.required' => 'User id không được trống !',
            'user_id.exists' => 'User id không tồn tại !'
        ];

        return parent::storeRequestValidate($request, $rules, $messages); // TODO: Change the autogenerated stub
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $rules = [
            'experience' => 'required|numeric',
            'specialize_id' => [
                'required',
                'exists:specializes,id',
                Rule::unique('specialize_details',)->where(function ($query) use ($id) {
                    return $query->where('user_id', '=', $this->currentUser()->id)
                        ->where('id', '!=', $id);
                }),
            ]
        ];

        $messages = [
            'experience.required' => 'Năm kinh nghiệm không được để trống !',
            'experience.numeric' => 'Năm kinh nghiệm không hợp lệ !',
            'specialize_id.required' => 'Chuyên môn không được để trống !',
            'specialize_id.exists' => 'Chuyên môn không tồn tại !',
            'specialize_id.unique' => 'Chuyên môn đã tồn tại !',
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages);
    }

    public function preDelete(int|string $id)
    {

        $userId = $this->currentUser()->id ?? null;
        $dataChildren = Certificate::where('specialize_detail_id', $id)->count();
        $dataChildrenCource = Course::where('specialize_detail_id', $id)->count();
        $specializeByUser = SpecializeDetail::where('user_id', '=', $userId)->where('id', '=', $id)->first();
        if (!$specializeByUser || $dataChildren > 0 || $dataChildrenCource > 0) {
            throw new BadRequestException(
                ['message' => 'Xóa không thành công !'], new Exception()
            );
        }
        parent::preDelete($id);
    }
}
