<?php

namespace App\Mail\Schedule;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Carbon;

class CancelComplainSchedule extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public $nameUser, $time_start, $time_end, $nameCourse, $nameUserCustomer;

    public function __construct($nameUser, $time_start, $time_end, $nameCourse, $nameUserCustomer)
    {
        $this->nameUser = $nameUser;
        $this->time_start = $time_start;
        $this->time_end = $time_end;
        $this->nameCourse = $nameCourse;
        $this->nameUserCustomer = $nameUserCustomer;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from('ngohongnguyenstudy2020@gmail.com', 'YM')
            ->subject('Học viên đã hủy khiếu nại khóa học vào ' . Carbon::now('Asia/Ho_Chi_Minh')
                    ->format('Y-m-d H:i:s'))
            ->view('Schedule.CancelComplainSchedule');
    }
}
