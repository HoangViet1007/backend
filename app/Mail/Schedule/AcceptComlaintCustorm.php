<?php

namespace App\Mail\Schedule;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AcceptComlaintCustorm extends Mailable
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
    protected $name_student;
    protected $date_complain;

    public function __construct($name_custorm,$name_cousre_plane, $name_pt, $date_complain)
    {
        $this->name_cousre_plane = $name_cousre_plane;
        $this->name_custorm = $name_custorm;
        $this->date_complain = $name_pt;
        $this->date_complain = $date_complain;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('Schedule.AcceptComlaintCustorm')
            ->subject('Thông báo đơn khiếu nại ' . $this->name_cousre_plane)
            ->with([
                'name_cousre_plane' => $this->name_cousre_plane,
                'name_pt' => $this->name_pt,
                'date_complain' => $this->date_complain,
                'name_custorm' => $this->name_custorm
            ]);
    }
}
