<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class CustormCancel extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    protected $teach_name;
    protected $student_name;
    protected $name_couser;
    protected $time_hour;
    protected $time_study;
    protected $reason;

    public function __construct($teach_name, $student_name, $time_hour, $time_study, $reason, $name_couser)
    {
        $this->teach_name = $teach_name;
        $this->student_name = $student_name;
        $this->student_name = $student_name;
        $this->time_hour = $time_hour;
        $this->time_study = $time_study;
        $this->reason = $reason;
        $this->name_couser = $name_couser;


    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.CustormCancel')
            ->subject('Mail xin nghỉ học '.$this->name_couser)
            ->with([
                'teach_name' => $this->teach_name,
                'student_name' => $this->student_name,
                'time_hour' => $this->time_hour,
                'time_study' => $this->time_study,
                'reason' => $this->reason,
                'name_couser' => $this->name_couser,

            ]);
    }
}
