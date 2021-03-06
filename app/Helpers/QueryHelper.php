<?php

namespace App\Helpers;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use App\Constants\DataCastConstant;
use App\Constants\OperatorConstant;

class QueryHelper
{
    protected array $operatorPatterns;

    /**
     * Operators to query into DB
     * @var array
     */
    protected array $operators
        = [
            '__gt' => OperatorConstant::GT, // Greater than (>)
            '__ge' => OperatorConstant::GE, // Greater than or equal (>=)
            '__lt' => OperatorConstant::LT, // Less than (<)
            '__le' => OperatorConstant::LE, // Less than or equal (<=)
            '__~'  => OperatorConstant::LIKE, // Like
            '___~' => OperatorConstant::I_LIKE,
            '__eq' => OperatorConstant::EQUAL // equal (=)
        ];

    /**
     * Operators were excluded
     * @var array|string[]
     */
    protected array $excludedOperators
        = [
            'limit',
            'page',
            'order_by'
        ];

    /**
     * Params will be cast to data type
     * @var array
     */
    protected array $castParams
        = [
            'date'       => DataCastConstant::DATE,
            'created_at' => DataCastConstant::DATETIME,
            'updated_at' => DataCastConstant::DATETIME,
            'age'        => DataCastConstant::NUMBER
        ];

    protected array $params = [];

    public array $relations = [];

    public string $driverConnectionName = 'mysql';

    public function __construct($driverConnectionName = 'mysql')
    {
        if ($driverConnectionName)
            $this->driverConnectionName = $driverConnectionName;
        $this->initDataForSpecificDatabase();
        $this->params           = request()->all();
        $this->operatorPatterns = array_keys($this->operators);
    }

    /**
     * Add more conditions
     *
     * @param array $param
     *
     * @return QueryHelper
     */
    public function addParams(array $param): static
    {
        $this->params = array_merge($this->params, $param);

        return $this;
    }

    /**
     * Remove one condition
     *
     * @param string $param
     *
     * @return QueryHelper
     */
    public function removeParam(string $param): static
    {
        if (key_exists($param, $this->params))
            unset($this->params[$param]);

        return $this;
    }

    /**
     * Add more cast params
     *
     * @param array $castParams
     *
     * @return QueryHelper
     */
    public function addCastParams(array $castParams): static
    {
        $this->params = array_merge($this->castParams, $castParams);

        return $this;
    }

    /**
     * Remove cast param
     *
     * @param string $castParam
     *
     * @return QueryHelper
     */
    public function removeCastParam(string $castParam): static
    {
        if (key_exists($castParam, $this->castParams))
            unset($this->params[$castParam]);

        return $this;
    }

    /**
     * Get all conditions from Request
     * @return array
     */
    public function getConditions(): array
    {
        // Remove all params of pagination
        foreach ($this->excludedOperators as $operator) {
            $this->removeParam($operator);
        }

        $conditions = [];
        foreach ($this->params as $paramKey => $paramValue) {
            if ($paramValue === '' || $paramValue === null) continue;

            // Basic query with equal clause
            if (!Str::endsWith($paramKey, $this->operatorPatterns)) {
                $column       = $this->_formatColumn($paramKey);
                $conditions[] = [
                    'column'   => $column,
                    'operator' => OperatorConstant::EQUAL,
                    'value'    => $this->_castParamValue($paramKey, $paramValue)
                ];
                continue;
            }

            foreach ($this->operators as $keyOperator => $operator) {
                if (!Str::endsWith($paramKey, $keyOperator))
                    continue;

                /**
                 * Get column from $paramKey
                 * $paramKey will be format with: {table}__{column}{operatorPatent}. Such as: user__age__lt OR age__lt OR age
                 */
                $column = Str::replaceLast($keyOperator, '', $paramKey);

                $column = $this->_formatColumn($column);

                // If $paramKey match $keyOperator
                $value        = $this->_castParamValue($column, $paramValue);
                $conditions[] = [
                    'column'   => $column,
                    'operator' => $operator,
                    'value'    => $operator === OperatorConstant::I_LIKE || $operator === OperatorConstant::LIKE
                        ? "%$value%"
                        : $value
                ];

            }
        }

        return $conditions;
    }

    /**
     * Format column name to query
     * Column fre convert will be format with: {table}__{column}. Such as user__age OR age
     *
     * @param string $column
     *
     * @return string
     */
    private function _formatColumn(string $column): string
    {
        $tmp = explode('__', $column);

        if (count($tmp) == 1)
            return $tmp[0];
        else
            return "$tmp[0].$tmp[1]";
    }

    /**
     * Cast data to specific DataType
     *
     * @param $column
     * @param $value
     *
     * @return float|int|Carbon|string
     */
    private function _castParamValue($column, $value): float|int|Carbon|string
    {
        if (!key_exists($column, $this->castParams))
            return $value;

        $dataType = $this->castParams[$column];

        return match ($dataType) {
            DataCastConstant::DATE => Carbon::createFromDate($value),
            DataCastConstant::DATETIME => Carbon::parse($value),
            DataCastConstant::NUMBER, DataCastConstant::DOUBLE => (double)$value,
            DataCastConstant::INT => (int)$value,
            default => (string)$value
        };
    }

    /**
     * Get limit records
     *
     * @return int
     */
    public static function limit(): int
    {
        return request('limit') ?? config('laravel-base.limit') ?? 10;
    }

    /**
     * Get Order by column and type
     *
     * @return array|null
     */
    public function getOrderBy(): ?array
    {
        $query = request()->input('order_by');
        if (!$query)
            return null;

        $sort = preg_split("/[\s]+/", trim($query));

        return [
            'column' => $sort[0],
            'type'   => $sort[1] ?? 'ASC'
        ];
    }

    /**
     * Add conditions and order by
     *
     * @param Model  $model
     *
     * @param String $alias
     *
     * @return Builder
     */
    public function buildQuery(Model|Builder $model, string $alias = ''): Builder
    {
        $tableName  = $model->getTable();
        $primaryKey = $model->getKeyName();

        if ($alias)
            $model = $model->from($tableName, $alias);

        if ($this->relations)
            $model = $model->with($this->relations);

        // Add where condition
        foreach ($this->getConditions() as $cond) {
            // If condition empty
            if (!$cond)
                continue;
            // If don't exist table or column
            // not work with mongodb
            // if (!Schema::hasTable($tableName))
            //    continue;
            $model = $model->where($cond['column'], $cond['operator'], $cond['value']);
        }

        // Sort data
        $order = $this->getOrderBy();

        if ($order) {
            $model = $model->orderBy($order['column'], $order['type']);
        } else {
            $model = $model->orderBy(($alias ? "$alias." : "") . $primaryKey, 'DESC');
        }

        return $model;
    }

    /**
     * Append excluded operators
     *
     * @param array $operators
     *
     * @return QueryHelper
     */
    public function addExcludedOperators(array $operators): static
    {
        array_push($this->excludedOperators, ...$operators);

        return $this;
    }

    /**
     * Add relations for query
     *
     * @param string|array $relations
     */
    public function with(string|array $relations)
    {
        $this->relations = (array)$relations;
    }

    public function initDataForSpecificDatabase()
    {
        switch ($this->driverConnectionName) {
            case 'pgsql':
                $this->operators['__~'] = OperatorConstant::I_LIKE; // iLike
                break;
            default:
                break;
        }
    }
}
