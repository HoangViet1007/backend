<?php

namespace App\Mail\Schedule;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ScheduleDontComplainPT extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */

    protected $name_cousre_plane;
    protected $name_pt;
    protected $date_complain;

    public function __construct($name_cousre_plane, $name_pt, $date_complain)
    {
        $this->name_cousre_plane = $name_cousre_plane;
        $this->name_pt = $name_pt;
        $this->date_complain = $date_complain;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('Schedule.ScheduleDontComplainPT')
            ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
            ->subject('Đơn khiếu nại ' . $this->name_cousre_plane . 'bị hủy')
            ->with([
                'name_cousre_plane' => $this->name_cousre_plane,
                'name_pt' => $this->name_pt,
                'date_complain' => $this->date_complain,
            ]);
    }
}
