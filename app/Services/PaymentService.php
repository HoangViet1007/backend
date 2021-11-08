<?php

namespace App\Services;

use App\Models\Payment;
use App\Models\User;
use App\Models\Bill;
use App\Models\CourseStudent;
use App\Models\Course;
use App\Constants\StatusConstant;
use Illuminate\Support\Facades\Auth;


/**
 * @Author apple
 * @Date   Oct 01, 2021
 */
class PaymentService extends BaseService
{
    function createModel(): void
    {
        $this->model = new Payment();
    }

    protected array $status = [StatusConstant::ACTIVE, StatusConstant::INACTIVE];

    public function createPayment(object $request)
    {
        $course_ids = Course::all()->pluck('id')->toArray();
        $this->doValidate(
            $request,
            [
                'course_id' => 'in:'. implode(',', $course_ids),
                'money' => 'required|numeric|min:0|max:50000000',
            ],
            [
                'course_id.in' => 'Không tồn tại khóa học!',
                'money.required' => 'Không có số tiền !',
                'money.numeric' => 'Số tiền không hợp lệ !',
                'money.min' => 'Số tiền không hợp lệ!',
                'money.max' => 'Số tiền không được quá 50 triệu đồng !',
            ]
        );
        if ($request->note == "thanh-toan") {
            $note = "Thanh toan khoa hoc";
        } else {
            $note = "Nap tien";
        }
        $vnp_TmnCode = "FN60B6S1"; //Mã website tại VNPAY
        $vnp_HashSecret = "UFHDGLVEXOKEGYQLICPHAPQQIZCKGTTP"; //Chuỗi bí mật
        $vnp_Url = "http://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
        if ($request->course_id) {
            $vnp_Returnurl = "http://localhost:3000/nap-tien/thong-bao?course_id=$request->course_id";
        } else {
            $vnp_Returnurl = "http://localhost:3000/nap-tien/thong-bao";
        }
        $vnp_TxnRef = date("YmdHis") . Auth::id(); //Mã đơn hàng. Trong thực tế Merchant cần insert đơn hàng vào DB và gửi mã này sang VNPAY
        $vnp_OrderInfo = $request->note;
        $vnp_Amount = $request->money * 100;
        $vnp_Locale = 'vn';
        $vnp_IpAddr = request()->ip();

        $inputData = array(
            "vnp_Version" => "2.1.0",
            "vnp_TmnCode" => $vnp_TmnCode,
            "vnp_Amount" => $vnp_Amount,
            "vnp_Command" => "pay",
            "vnp_CreateDate" => date('YmdHis'),
            "vnp_CurrCode" => "VND",
            "vnp_IpAddr" => $vnp_IpAddr,
            "vnp_Locale" => $vnp_Locale,
            "vnp_OrderInfo" => $note,
            "vnp_ReturnUrl" => $vnp_Returnurl,
            "vnp_TxnRef" => $vnp_TxnRef,
        );

        if (isset($vnp_BankCode) && $vnp_BankCode != "") {
            $inputData['vnp_BankCode'] = $vnp_BankCode;
        }

        ksort($inputData);

        $query = "";
        $i = 0;
        $hashdata = "";
        foreach ($inputData as $key => $value) {
            if ($i == 1) {
                $hashdata .= '&' . urlencode($key) . "=" . urlencode($value);
            } else {
                $hashdata .= urlencode($key) . "=" . urlencode($value);
                $i = 1;
            }
            $query .= urlencode($key) . "=" . urlencode($value) . '&';
        }

        $vnp_Url = $vnp_Url . "?" . $query;
        if (isset($vnp_HashSecret)) {
            $vnpSecureHash = hash_hmac('sha512', $hashdata, $vnp_HashSecret); //
            $vnp_Url .= 'vnp_SecureHash=' . $vnpSecureHash;
        }
        //        dd($vnp_Url);
        return $vnp_Url;
    }

    public function returnPayment($request)
    {
        $course_ids = Course::all()->pluck('id')->toArray();
        $this->doValidate(
            $request,
            [
                'course_id' => 'in:'. implode(',', $course_ids),
                'money' => 'required|numeric|min:0|max:50000000',
            ],
            [
                'course_id.in' => 'Không tồn tại khóa học!',
                'money.required' => 'Không có số tiền !',
                'money.numeric' => 'Số tiền không hợp lệ !',
                'money.min' => 'Số tiền không hợp lệ!',
                'money.max' => 'Số tiền không được quá 50 triệu đồng !',
            ]
        );
        $returnData = [
            "money" => $request->money / 100, //vnp_Amount / 100,
            "code_vnp_response" => $request->code_vnp_response, //vnp_ResponseCode,
            "code_bank" => $request->code_bank, //vnp_BankCode,
            "code_vnp" => $request->code_vnp, //vnp_TransactionNo,
            "time" => date('Y-m-d H:i:s'),
            "user_id" => Auth::user()->id,
        ];
        if ($request->course_id) {
            $billData = [
                "code_bill" => $request->code_bill, // vnp_TxnRef
                "time" => date('Y-m-d H:i:s'),
                "money" => $request->money / 100, //vnp_Amount / 100,
                "status" => StatusConstant::DIRECT,
                "course_id" => $request->course_id,
                "user_id" => Auth::id()
            ];
//             them vao bang hoc vien
            $courseStudentData = [
                "status" => StatusConstant::UNSCHEDULED,
                "user_id" => Auth::id(),
                "course_id" => $request->course_id
            ];
            CourseStudent::create($courseStudentData);
            //                dd($returnData, $billData);
            $bill = Bill::create($billData);
            $returnData['bill_id'] = $bill->id;
            $returnData['note'] = "Thanh toan khoa hoc";

        } else {
            // cong tien user
            $user = User::find(Auth::id());
            $money = [
                'money' => $user->money + $request->money / 100
            ];
            $user->update($money);
            $returnData['note'] = "Nap tien";
        }
        $payment = Payment::create($returnData);
        $paymentRel = Payment::with('bill.course', 'user')->where('payments.id', $payment->id)->first();
        return $paymentRel;
    }
}
