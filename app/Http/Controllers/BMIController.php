<?php

namespace App\Http\Controllers;

use App\Exceptions\SystemException;
use App\Http\Requests\BMIRequest;
use Exception;
use Illuminate\Http\JsonResponse;

class BMIController extends Controller
{
    public function countBMI(BMIRequest $request): JsonResponse
    {
        try {
            $message = "";
            $weight  = (float)$request['weight'];
            $height  = (float)$request['height'];
            $BMI     = number_format(($weight / ($height * 2)), 2, '.', '');

            if ($height < 2) {
                $ideal_weight = number_format(($height - floor($height)) * 100 * 9 / 10, 0, '.', '');
            } else {
                $ideal_weight = number_format(($height - floor($height)) * 1000 * 9 / 10, 0, '.', '');
            }

            if ($BMI < 18.5) {
                $message = "Cân nặng của bạn đang thấp , hãy cải thiện chế độ ăn uống để tăng cân nha !";
            } elseif (18.5 <= $BMI && $BMI <= 24.9) {
                $message = "Cân nặng của bạn đang bình thường !";
            } elseif ($BMI >= 25) {
                $message = "Bạn đang thừa cân, hãy cản thiện chế độ ăn uống nha !";

            } elseif ($BMI > 25 && $BMI <= 29.9) {
                $message = "Bạn đang bị tiền béo phì, hãy cản thiện chế độ ăn uống nha !";
            } elseif ($BMI >= 30 && $BMI <= 34.9) {
                $message
                    = "Bạn đang bị béo phì độ 1, hãy cải thiện ngay chế độ ăn uống và tập luyện để không có những ảnh hướng xấu đối với sức khoẻ !";
            } elseif ($BMI >= 35 && $BMI <= 39.9) {
                $message
                    = "Bạn đang bị béo phì độ 2, hãy cải thiện ngay chế độ ăn uống và tập luyện để không có những ảnh hướng xấu đối với sức khoẻ !";
            } else {
                $message
                    = "Bạn đang bị béo phì độ 3, hãy cải thiện ngay chế độ ăn uống và tập luyện để không có những ảnh hướng xấu đối với sức khoẻ !";
            }

            return response()->json(['BMI' => $BMI, 'ideal_weight' => $ideal_weight, 'status' => true, 'code' => 200, 'message' => $message]);
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }


    }
}
