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

    protected $price;
    public function __construct($name_student,$name_couser,$price)
    {
        $this->name_student = $name_student;
        $this->name_couser = $name_couser;
        $this->price = $price;

    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.cancelCourse')
            ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
            ->subject('Email thông báo hủy khóa học '.$this->name_couser)
            ->with([
                'name_student' => $this->name_student,
                'name_couser' => $this->name_couser,
                'price' => $this->price,

            ]);
    }
}
