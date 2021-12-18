<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class GetPassword extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    protected $password;
    protected $user;

    public function __construct($user, $password)
    {
        $this->password = $password;
        $this->user     = $user;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('GetPassword')
                    ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
                    ->subject('Email lấy lại mật khẩu')
                    ->with([
                               'password' => $this->password,
                               'user'     => $this->user
                           ]);
    }
}
