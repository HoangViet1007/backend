<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Auth\Events\Registered;
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

    public function addUserVerify()
    {
        $user = User::where('id', 1)->first();
        $user->email = 'ngohongnguyen016774@gmail.com';

        return event(new Registered($user));
    }
}
