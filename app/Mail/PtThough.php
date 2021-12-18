<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class PtThough extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public $student_name;
    public $created_at;
    public $teacher_name;
    public $name_course;

    public function __construct($student_name, $created_at, $teacher_name, $name_course)
    {
        $this->student_name = $student_name;
        $this->name_course  = $name_course;
        $this->created_at   = $created_at;
        $this->teacher_name = $teacher_name;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.ptThough')
                    ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
                    ->subject('Thư thông báo khoá học đã được duyệt')
                    ->with([
                               'student_name' => $this->student_name,
                               'name_course'  => $this->name_course,
                               'created_at'   => $this->created_at,
                               'teacher_name' => $this->teacher_name,
                           ]);

    }
}
