<?php

namespace App\Mail\Schedule;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ScheduleCourseCustorm extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    protected $name_student;
    protected $arr_schedule;
    protected $date;

    public function __construct($name_student, $arr_schedule, $date)
    {
        $this->name_student = $name_student;
        $this->arr_schedule = $arr_schedule;
        $this->date = $date;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('Schedule.ScheduleCourseCustorm')
            ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
            ->subject('Thông báo lịch học ngày ' . $this->date)
            ->with([
                'name_student' => $this->name_student,
                'arr_schedule' => $this->arr_schedule
            ]);
    }
}
