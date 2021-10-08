<?php

namespace App\Http\Controllers;

use App\Constants\StatusConstant;
use App\Models\User;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Laravel\Socialite\Facades\Socialite;

class GoogleController extends Controller
{
    public function redirectToProvider()
    {
        return response()->json([
                                    'url' => Socialite::driver('google')->stateless()->redirect()->getTargetUrl(),
                                ]);
    }

    public function handleProviderCallback(): JsonResponse
    {
        try {
            $user = Socialite::driver('google')->stateless()->user();
        } catch (Exception $e) {
            return response()->json([
                                      'url' => Socialite::driver('google')->stateless()->redirect()->getTargetUrl(),
                                  ]);
        }
        DB::transaction(function () use ($user) {
            if (!User::where('email', $user->getEmail())->first()) {
                User::create([
                                 'email'          => $user->getEmail(),
                                 'name'           => $user->getName(),
                                 'image'          => $user->getAvatar(),
                                 'status'         => StatusConstant::ACTIVE,
                                 'password'       => $user->getId(),
                                 'socialite_id'   => $user->getId(),
                                 'type_socialite' => 'google'
                             ]);
            }
        });

        return response()->json([
                                    'google_user' => $user,
                                ]);
    }
}
