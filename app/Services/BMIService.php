<?php

namespace App\Services;

use App\Models\User;

/**
 * @Author apple
 * @Date   Sep 30, 2021
 */
class BMIService extends BaseService
{

    function createModel(): void
    {
        $this->model = new User();
    }

    public function BMI(object $request)
    {
        $rules = [
            'weight' => 'required|min:1',
            'height' => 'required|min:1'
        ];
        if($this->doValidate($request, $rules)){
            $weight = (float)$request['weight'];
            $height = (float)$request['height'];
            $heightM = $height * 0.01;
            $BMI = ($weight/($heightM*$heightM));
        }
        $BMI->{'BMI'} = $BMI;
        return $BMI;
    }


}
