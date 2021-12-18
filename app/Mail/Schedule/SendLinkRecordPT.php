<?php

namespace App\Mail\Schedule;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendLinkRecordPT extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    protected $name_student;
    protected $name_cousre_plane;
    protected $name_pt;
    protected $date_complain;
    protected $content;

    public function __construct($name_student, $name_cousre_plane, $name_pt, $date_complain, $content)
    {
        $this->name_student = $name_student;
        $this->name_pt = $name_pt;
        $this->name_cousre_plane = $name_cousre_plane;
        $this->date_complain = $date_complain;
        $this->content = $content;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('Schedule.SendLinkRecordPT')
            ->subject('Yêu cầu gửi link Record')
            ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
            ->with([
                'name_student' => $this->name_pt,
                'name_cousre_plane' => $this->name_cousre_plane,
                'name_pt' => $this->name_pt,
                'date_complain' => $this->date_complain,
                'content' => $this->content
            ]);
    }
}
