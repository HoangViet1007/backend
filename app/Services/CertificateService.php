<?php

namespace App\Services;

use App\Constants\StatusConstant;
use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\Certificate;
use App\Models\SpecializeDetail;
use App\Models\User;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

/**
 * @Author apple
 * @Date   Sep 30, 2021
 */
class CertificateService extends BaseService
{
    protected array $status = [StatusConstant::PROCESS, StatusConstant::PROCESSED];

    function createModel(): void
    {
        $this->model = new Certificate();
    }

    public function getAll(): LengthAwarePaginator
    {
        $idUser = auth()->user()->id;
        $this->preGetAll();
        $data = $this->queryHelper->buildQuery($this->model)->with(['user', 'specializes'])
            ->join('specialize_details', 'certificates.specialize_detail_id',
                'specialize_details.id')
            ->join('users',
                function ($join) use ($idUser) {
                    $join->on('users.id', '=', 'specialize_details.user_id')
                        ->where('users.id', $idUser);
                })
            ->select('certificates.*');;


        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function listCertificatesSpecialize($id)
    {
        try {
            $response = Certificate::where('specialize_detail_id', $id)->get();
            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    /**
     * @param object $request
     * @param array $rules
     * @param array $messages
     * @return bool|array
     */


    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $idUser = auth()->user()->id;
        $idArray = SpecializeDetail::where('user_id',$idUser)->get('id')->toArray();
        $array =[];
       foreach ($idArray as $value){
           array_push($array,$value['id']);
       }
        $rules = [
            'name' => [
                'required',
                'max:100',
                Rule::unique('certificates',)->where(function ($query) use ($request) {
                    return $query->where('specialize_detail_id', $request->specialize_detail_id);
                }),
            ],
            'image' => 'required',
            'specialize_detail_id' => 'required|in:' . implode(',',$array),
        ];
        $messages = [
            'name.required' => 'Hãy nhập tên chứng chỉ !',
            'name.unique' => 'Tên chứng chỉ đã tồn tại !',
            'name.max' => 'Tên chứng chỉ không quá 100 ký tự !',
            'image.required' => 'Hãy nhập ảnh !',
            'specialize_detail_id.required' => 'Hãy chọn chuyên môn của chứng chỉ !',
            'specialize_detail_id.in' => 'Chuyên môn không tồn tại !',
        ];

        return parent::storeRequestValidate($request, $rules, $messages);
    }


    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array $messages = []): bool|array
    {
        $idUser = auth()->user()->id;
        $idArray = SpecializeDetail::where('user_id',$idUser)->get('id')->toArray();
        $array =[];
        foreach ($idArray as $value){
            array_push($array,$value['id']);
        }

        $rules = [
            'name' => [
                'required',
                'max:100',
                Rule::unique('certificates',)->where(function ($query) use ($request,$id) {
                    return $query->where('specialize_detail_id', $request->specialize_detail_id)
                        ->where('id', '!=', $id);
                        ;
                }),
            ],
            'image' => 'required',
            'specialize_detail_id' => 'required|in:' . implode(',',$array),
        ];
        $messages = [
            'name.required' => 'Hãy nhập tên chứng chỉ !',
            'name.unique' => 'Tên chứng chỉ đã tồn tại !',
            'name.max' => 'Tên chứng chỉ không quá 100 ký tự !',
            'image.required' => 'Hãy nhập ảnh !',
            'specialize_detail_id.required' => 'Hãy chọn chuyên môn của chứng chỉ !',
            'specialize_detail_id.in' => 'Chuyên môn không tồn tại !',
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages);
    }

}
