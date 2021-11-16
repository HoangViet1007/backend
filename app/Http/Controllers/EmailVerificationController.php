<?php

namespace App\Http\Controllers;

use Illuminate\Auth\Events\Verified;
use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\EmailVerificationRequest;

class EmailVerificationController extends Controller
{
    public function sendEmailVerification(Request $request)
    {
        if ($request->user()->hasVerifiedEmail()) {
            return ['message' => 'Da xac thuc'];
        } else {
            $request->user()->sendEmailVerificationNotification();
            return ['satatus' => 'verifile link send'];
        }
    }

    public function verify(EmailVerificationRequest $request)
    {

        $request->fulfill();
        return ['message' => 'Check success'];

    }
}
