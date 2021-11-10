<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
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
    // tên học viên
    protected $name_student;
    // thông tin khóa học
    // ngày học
    protected $date_study;
    // tên khóa học
    protected $name_couser;
    // thời gian bắt đầu
    protected $time_hour;
    // tên PT
    protected $name_pt;
    // số điện thoai PT
    protected $phone_pt;
    // link room
    protected $link_room;

    public function __construct($name_student,$date_study,$name_couser,$time_hour,$name_pt,$phone_pt,$link_room)
    {
        $this->name_student = $name_student;
        $this->date_study = $date_study;
        $this->name_couser = $name_couser;
        $this->time_hour = $time_hour;
        $this->name_pt = $name_pt;
        $this->phone_pt = $phone_pt;
        $this->link_room = $link_room;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.scheduleCourse')
            ->subject('Email thông báo lịch học')
            ->with([
                'name_student' => $this->name_student,
                'date_study' => $this->date_study,
                'name_couser' => $this->name_couser,
                'time_hour' => $this->time_hour,
                'name_pt' => $this->name_pt,
                'phone_pt' => $this->phone_pt,
                'link_room' => $this->link_room,
            ]);
    }
}
