<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class PTCantTeach extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    protected $student_name;
    protected $time_study;
    protected $name_couser;
    protected $time_hour;
    public function __construct($student_name, $time_study, $name_couser, $time_hour)
    {
        $this->student_name =$student_name;
        $this->time_study =$time_study;
        $this->name_couser =$name_couser;
        $this->time_hour =$time_hour;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.ptCantTeach')
            ->subject('PT không thể dạy ')
            ->with([
                'studentName' => $this->student_name,
                'time_study' => $this->time_study,
                'name_couser' => $this->name_couser,
                'time_hour' => $this->time_hour,
            ]);

    }
}
