<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
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
    protected $created_at;

    public function __construct($student_name, $time_study, $name_couser, $created_at)
    {
        $this->student_name = $student_name;
        $this->time_study   = $time_study;
        $this->name_couser  = $name_couser;
        $this->created_at   = $created_at;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.ptCantTeach')
                    ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
                    ->subject('Thư huỷ khoá học từ phía PT')
                    ->with([
                               'studentName' => $this->student_name,
                               'time_study'  => $this->time_study,
                               'name_couser' => $this->name_couser,
                               'created_at'  => $this->created_at,
                           ]);

    }
}
