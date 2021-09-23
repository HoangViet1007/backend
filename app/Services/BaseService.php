<?php
/**
 * @Author apple
 * @Date   Sep 22, 2021
 */

namespace App\Services;

use App\Models\Demo;
use Exception;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Validator;
use Symfony\Component\HttpFoundation\Exception\BadRequestException;

abstract class BaseService
{
    public Model|Builder $model;
    public static bool   $validateThrowAble = true;

    public function __construct()
    {
        $this->createModel();
    }

    /**
     * Create new Model
     * @return void
     */
    abstract function createModel(): void;

    public function getAll(object $request)
    {
        $this->preGetAll();
        try {
            // get param
            $searchKey = $request->search_key ?? null;
            // get fillable
            $fillable = (new Demo())->getFillable();
            $fields   = is_array($fillable) ? $fillable : [];
            $limit    = $request->get('limit') ?? config('common.data.limit');
            $OrderBys = [];

            // gan value cho orderby
            if ($request->get('column') && $request->get('sort')) {
                $OrderBys['column'] = $request->get('column');
                $OrderBys['sort']   = $request->get('sort');
            }

            // custome querry
            $data = Demo::query();
            if ($OrderBys) {
                $response = $data->orderBy($OrderBys['column'], $OrderBys['sort']);
            }

            $response = $data->when($searchKey && count($fillable) > 0, function ($q) use ($fillable, $searchKey) {
                $q->where(function ($q) use ($searchKey, $fillable) {
                    foreach ($fillable as $field) {
                        $q->orWhere($field, 'LIKE', '%' . $searchKey . '%');
                    }
                });
            });
            $response = $data->paginate($limit);
            $this->postGetAll($response);

            return $response;
        } catch (Exception $e) {
            throw new BadRequestException(
                [
                    'message' => __("get all data error")
                ], new Exception()
            );
        }
    }

    public function get($id)
    {
        $this->preGet($id);
        try {
            $response = Demo::findOrFail($id);
            $this->postGet($id, $response);

            return $response;
        } catch (Exception $e) {
            throw new BadRequestException(
                ['message' => __("get data error")], new Exception()
            );
        }
    }

    public function add(object $request)
    {
        DB::beginTransaction();
        $request = $this->preAdd($request) ?? $request;

        // Set data to new entity
        $fillAbles = $this->model->getFillable();
        $guarded   = $this->model->getGuarded();

        // Validate
        if ($this->storeRequestValidate($request) !== true) {
            return $this->model;
        }

        foreach ($fillAbles as $fillAble) {
            if (isset($request->$fillAble) && !in_array($fillAble, $guarded)) {
                $this->model->$fillAble = $this->_handleRequestData($request->$fillAble);
            }
        }

        try {
            $this->model->save();
            $this->postAdd($request, $this->model);
            DB::commit();

            return $this->model;
        } catch (Exception $e) {
            DB::rollBack();
            throw new BadRequestException(
                ['message' => __("add data error")], new Exception()
            );
        }
    }

    /**
     * Update an Entity via ID
     *
     * @param int|string $id
     * @param object     $request
     *
     * @return Model
     */
    public function update(int|string $id, object $request): Model
    {
        DB::beginTransaction();
        $request = $this->preUpdate($id, $request) ?? $request;

        // Set data for updated entity
        $fillAbles = $this->model->getFillable();
        $guarded   = $this->model->getGuarded();

        // Validate
        if ($this->updateRequestValidate($id, $request) !== true) {
            return $this->model;
        }

        $model = $this->get($id);

        foreach ($fillAbles as $fillAble) {
            if (isset($request->$fillAble) && !in_array($fillAble, $guarded)) {
                $model->$fillAble = $this->_handleRequestData($request->$fillAble) ?? $model->$fillAble;
            }
        }
        try {
            $model->save();
            $this->postUpdate($id, $request, $model);
            DB::commit();

            return $model;
        } catch (Exception $e) {
            DB::rollBack();
            throw new BadRequestException(
                ['message' => __("update data error")], new Exception()
            );
        }
    }

    /**
     * Delete a Entity via ID
     *
     * @param int|string $id
     *
     * @return bool
     */
    public function delete(int|string $id): bool
    {
        DB::beginTransaction();
        $this->preDelete($id);
        $data = $this->get($id);
        try {
            $deleted = $data->delete();
            $this->postDelete($id);
            DB::commit();

            return $deleted;
        } catch (Exception $e) {
            DB::rollBack();
            throw new BadRequestException(
                ['message' => __("delete data error")], new Exception()
            );
        }
    }

    /**
     * Delete multiple Entity via IDs
     *
     * @param object $request
     *
     * @return bool
     */
    public function deleteByIds(object $request): bool
    {
        $this->preDeleteByIds($request);
        $this->doValidate($request, ['ids' => 'required|array']);
        $idField = $this->model->getKey();
        if (!Schema::hasColumn($this->model->getTable(), $idField)) {
            throw new BadRequestException(
                ['message' => __("not-exist", ['attribute' => __('entity')]) . ": $request->ids"], new Exception()
            );
        }
        $data = $this->model->whereIn($idField, $request->ids);
        try {
            $deleted = $data->delete();
            $this->postDeleteByIds($request);

            return $deleted;
        } catch (Exception $e) {
            throw new BadRequestException(
                ['message' => __("delete data error")], new Exception()
            );
        }
    }

    /**
     * @param object $request
     * @param array  $rules
     *
     * @return bool|array
     */
    public static function doValidate(object $request, array $rules = []): bool|array
    {
        if ($request instanceof Request)
            $request = $request->all();
        elseif ($request instanceof Model)
            $request = $request->toArray();
        else
            $request = (array)$request;

        $validator = Validator::make($request, $rules);

        if ($validator?->fails()) {
            if (self::$validateThrowAble)
                throw new BadRequestException(['messages' => $validator->errors()->toArray()], new Exception());
            else
                return $validator->errors()->toArray();
        }

        return true;
    }

    /**
     */
    public function preGetAll()
    {
        // TODO: Implement preGetAll() method.
    }

    /**
     * @param object $model
     */
    public function postGetAll(object $model)
    {
        // TODO: Implement postGetAll() method.
    }


    /**
     * @param int|string $id
     */
    public function preGet(int|string $id)
    {
        // TODO: Implement preGet() method.
    }

    /**
     * @param int|string $id
     * @param Model      $model
     */
    public function postGet(int|string $id, Model $model)
    {
        // TODO: Implement postGet() method.
    }

    /**
     * @param object $request
     */
    public function preAdd(object $request)
    {
        // TODO: Implement preAdd() method.
    }

    /**
     * @param object $request
     * @param Model  $model
     */
    public function postAdd(object $request, Model $model)
    {
        // TODO: Implement postAdd() method.
    }

    /**
     * @param int|string $id
     * @param object     $request
     */
    public function preUpdate(int|string $id, object $request)
    {
        // TODO: Implement preUpdate() method.
    }

    /**
     * @param int|string $id
     * @param object     $request
     * @param Model      $model
     */
    public function postUpdate(int|string $id, object $request, Model $model)
    {
        // TODO: Implement postUpdate() method.
    }

    /**
     * @param int|string $id
     */
    public function preDelete(int|string $id)
    {
        // TODO: Implement preDelete() method.
    }

    /**
     * @param int|string $id
     */
    public function postDelete(int|string $id)
    {
        // TODO: Implement postDelete() method.
    }

    /**
     * @param object $request
     */
    public function preDeleteByIds(object $request)
    {
        // TODO: Implement preDelete() method.
    }

    /**
     * @param object $request
     */
    public function postDeleteByIds(object $request)
    {
        // TODO: Implement postDelete() method.
    }

    /**
     * @param mixed $value
     *
     * @return mixed
     */
    private function _handleRequestData(mixed $value): mixed
    {
        if (gettype($value) === 'string')
            return trim($value);
        else
            return $value;
    }

    /**
     * Validate store request
     *
     * @param object $request
     * @param array  $rules
     *
     * @return bool|array
     */
    public function storeRequestValidate(object $request, array $rules = []): bool|array
    {
        if (!$rules || !$request)
            return true;

        return $this->doValidate($request, $rules);
    }

    /**
     * Validate update request
     *
     * @param int|string $id
     * @param object     $request
     * @param array      $rules
     *
     * @return bool|array
     */
    public function updateRequestValidate(int|string $id, object $request, array $rules = []): bool|array
    {
        if (!$rules || !$id || !$request)
            return true;

        return $this->doValidate($request, $rules);
    }

}
