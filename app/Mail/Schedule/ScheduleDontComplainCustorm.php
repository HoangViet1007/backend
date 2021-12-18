<?php

namespace App\Mail\Schedule;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class ScheduleDontComplainCustorm extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    protected $name_custorm;
    protected $name_cousre_plane;
    protected $name_pt;
    protected $date_complain;

    public function __construct($name_custorm, $name_cousre_plane, $name_pt, $date_complain)
    {
        $this->name_pt = $name_pt;
        $this->name_custorm = $name_custorm;
        $this->name_cousre_plane = $name_cousre_plane;
        $this->date_complain = $date_complain;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('Schedule.ScheduleDontComplainCustorm')
            ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
            ->subject('Đơn khiếu nại khóa học ' . $this->name_cousre_plane . ' bị hủy')
            ->with([
                'name_pt' => $this->name_pt,
                'name_custorm' => $this->name_custorm,
                'name_cousre_plane' => $this->name_cousre_plane,
                'date_complain' => $this->date_complain
            ]);
    }
}
