<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
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
    protected $teacher_name;
    protected $student_name;
    protected $name_courser;
    protected $created_at;
    protected $description;

    public function __construct($teacher_name, $student_name, $name_courser, $created_at, $description)
    {
        $this->teacher_name = $teacher_name;
        $this->student_name = $student_name;
        $this->name_courser = $name_courser;
        $this->created_at   = $created_at;
        $this->description  = $description;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.CustormCancel')
                    ->subject('Mail huỷ khoá học từ khách hàng')
                    ->with([
                               'teacher_name' => $this->teacher_name,
                               'student_name' => $this->student_name,
                               'name_courser' => $this->name_courser,
                               'created_at'   => $this->created_at,
                               'description'  => $this->description,
                           ]);
    }
}
