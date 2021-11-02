<?php

namespace App\Http\Requests\Payment;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\Course;

class CreatePayentRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "money" => "required|numeric|min:0",
            "note" => "required",
            'course_id' => 'in:' . implode(',', Course::all()->id),
        ];
    }

    public function messages()
    {
        return [
            'money.required' => 'Số tiền không được trống !',
            'money.numeric' => 'Số tiền không hợp lệ !',
            'money.min' => 'Số tiền không hợp lệ !',
            'note.required' => 'Loại thannh toán không được để trống !',
            'course_id.in' => 'Khóa học thanh toán không hợp lệ !',
        ];
    }
}
