<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class sendEmailContact extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    protected $name;
    protected $email;
    protected $title;
    protected $phone;
    protected $description;

    public function __construct($name, $email, $title, $phone, $description)
    {
        $this->name        = $name;
        $this->email       = $email;
        $this->title       = $title;
        $this->phone       = $phone;
        $this->description = $description;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('send_email.sendEmailContact')
                    ->from('ngohongnguyenstudy2020@gmail.com', 'YM')
                    ->subject($this->title)
                    ->with([
                               'name'        => $this->name,
                               'title'       => $this->title,
                               'email'       => $this->email,
                               'phone'       => $this->phone,
                               'description' => $this->description
                           ]);
    }
}
