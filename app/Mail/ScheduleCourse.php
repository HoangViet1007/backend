<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ScheduleCourse extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */


    protected $name_pt;
    // lịch học trong ngày
    protected $arr_schedule;
    // ngày hiện tại
    protected $date;

    public function __construct($name_pt, $arr_schedule, $date)
    {
        $this->name_pt      = $name_pt;
        $this->arr_schedule = $arr_schedule;
        $this->date         = $date;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.scheduleCourse')
                    ->subject('Email thông báo lịch dạy học ngày ' . $this->date)
                    ->with([
                               'name_pt'      => $this->name_pt,
                               'arr_schedule' => $this->arr_schedule
                           ]);
    }
}
