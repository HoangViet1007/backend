<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Carbon;

class Rechage extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public $code_bank, $code_vnp, $nameUser, $money, $time, $note;
    public function __construct($code_bank, $code_vnp, $nameUser, $money, $time, $note)
    {
        $this->code_bank = $code_bank;
        $this->code_vnp = $code_vnp;
        $this->nameUser = $nameUser;
        $this->money = $money;
        $this->time = $time;
        $this->note = $note;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from('ngohongnguyenstudy2020@gmail.com', 'YM')->subject('Email xác nạp tiền thành công vào ngày ' . Carbon::now('Asia/Ho_Chi_Minh')->format('Y-m-d H:i:s'))->view('Money.Rechage');
    }
}
