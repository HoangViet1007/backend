<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AdminThough extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public $teacher_name;
    public $name_course;

    public function __construct($teacher_name, $name_course)
    {
        $this->name_course  = $name_course;
        $this->teacher_name = $teacher_name;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.AdminThough')
                    ->subject('Thư thông báo khoá học đã được duyệt')
                    ->with([
                               'name_course'  => $this->name_course,
                               'teacher_name' => $this->teacher_name,
                           ]);
    }
}
