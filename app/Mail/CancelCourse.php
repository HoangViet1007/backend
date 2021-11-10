<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class CancelCourse extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */

    protected $name_student;
    // thông tin khóa học
    // tên khóa học
    protected $name_couser;
    public function __construct($name_student,$name_couser)
    {
        $this->name_student = $name_student;
        $this->name_couser = $name_couser;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.cancelCourse')
            ->subject('Email thông báo hủy khóa học')
            ->with([
                'name_student' => $this->name_student,
                'name_couser' => $this->name_couser,
            ]);
    }
}
