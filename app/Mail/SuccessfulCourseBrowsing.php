<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SuccessfulCourseBrowsing extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    protected $name_student;
    protected $name_course;
    protected $price;
    protected $name_pt;
    public function __construct($name_student, $name_course, $price, $name_pt)
    {
        $this->name_student = $name_student;
        $this->name_course = $name_course;
        $this->price = $price;
        $this->name_pt = $name_pt;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.SuccessfulCourseBrowsing')
            ->subject("Đăng ký khóa học ".$this->name_course." thành công!")
            ->with([
                'name_student' => $this->name_student,
                'name_couser' => $this->name_course,
                'price' => $this->price,
                'name_pt' => $this->name_pt,
            ]);
    }
}
