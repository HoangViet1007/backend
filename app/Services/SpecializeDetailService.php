<?php

namespace App\Services;

use App\Exceptions\SystemException;
use App\Helpers\QueryHelper;
use App\Models\SpecializeDetail;
use Exception;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

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

    public function getAll(): LengthAwarePaginator
    {
        $this->preGetAll();
        $id   = $this->currentUser()->id ?? null;
        $data = $this->queryHelper->buildQuery($this->model)->where('user_id', $id);
        try {
            $response = $data->paginate(QueryHelper::limit());
            $this->postGetAll($response);

            return $response;
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function storeRequestValidate(object $request, array $rules = [], array $messages = []): bool|array
    {
        $rules    = [
            'experience'    => 'required|numeric',
            'specialize_id' => 'required|exists:specializes,id',
        ];
        $messages = [
            'experience.required'    => 'Năm kinh nghiệm không được để trống !',
            'experience.numeric'     => 'Năm kinh nghiệm không hợp lệ !',
            'specialize_id.required' => 'Chuyên môn không được để trống !',
            'specialize_id.exists'   => 'Chuyên môn không tồn tại !'
        ];

        return parent::storeRequestValidate($request, $rules, $messages);
    }

    public function updateRequestValidate(int|string $id, object $request, array $rules = [],
                                          array      $messages = []): bool|array
    {
        $rules = [
            'experience'    => 'required|numeric',
            'specialize_id' => 'required|exists:specializes,id',
        ];

        $messages = [
            'experience.required'    => 'Năm kinh nghiệm không được để trống !',
            'experience.numeric'     => 'Năm kinh nghiệm không hợp lệ !',
            'specialize_id.required' => 'Chuyên môn không được để trống !',
            'specialize_id.exists'   => 'Chuyên môn không tồn tại !'
        ];

        return parent::updateRequestValidate($id, $request, $rules, $messages);
    }
}
