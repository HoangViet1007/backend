<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Carbon;


class CoursePayment extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public $code_bill, $nameUser, $nameCourse, $money, $time, $status;
    public function __construct($code_bill, $nameUser, $nameCourse, $money, $time, $status)
    {
        $this->code_bill = $code_bill;
        $this->nameUser = $nameUser;
        $this->nameCourse = $nameCourse;
        $this->money = $money;
        $this->time = $time;
        $this->status = $status;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from('ngohongnguyenstudy2020@gmail.com', 'YM')->subject('Đơn hàng mua khóa học xác nhận ngày ' . Carbon::now('Asia/Ho_Chi_Minh')->format('Y-m-d H:i:s'))->view('Money.CoursePayment');
    }
}
