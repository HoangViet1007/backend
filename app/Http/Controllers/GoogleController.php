<?php

namespace App\Http\Controllers;

use App\Constants\StatusConstant;
use App\Exceptions\SystemException;
use App\Models\SocialAccount;
use App\Models\User;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Laravel\Socialite\Facades\Socialite;

class GoogleController extends Controller
{
    public function redirectToProvider()
    {
        return Socialite::driver('google')->stateless()->redirect();
    }

    public function handleProviderCallback(): JsonResponse
    {
        try {
            $userSocial = Socialite::driver('google')->stateless()->user();
            $user       = null;

            DB::transaction(function () use ($userSocial, &$user) {
                $socialAccount = SocialAccount::firstOrNew(
                    ['social_id' => $userSocial->getId(), 'social_provider' => 'google']
                );

                if (!($user = $socialAccount->user)) {
                    $user = User::create([
                                             'email'             => $userSocial->getEmail(),
                                             'name'              => $userSocial->getName(),
                                             'image'             => $userSocial->getAvatar(),
                                             'status'            => StatusConstant::ACTIVE,
                                             'password'          => $userSocial->getId(),
                                             'email_verified_at' => Carbon::now()->toDateTimeString(),
                                         ]);
                    $socialAccount->fill(['user_id' => $user->id])->save();
                }
            });

            $accessToken = $user->createToken('Personal Access Token')->accessToken;

            return response()->json([
                                        'access_token' => $accessToken,
                                        'google_user' => $userSocial,
                                    ]);
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function loginAccountGoogle(Request $request): JsonResponse
    {
        try {
            $userSocial = Socialite::driver('google')->stateless()
                                   ->userFromToken($request->access_token);
            $email      = $userSocial->getEmail();
            $social_id  = $userSocial->getId();
            $user       = User::join('social_accounts', 'social_accounts.user_id', 'users.id')
                              ->where(function ($query) use ($email, $social_id) {
                                  $query->where('users.email', '=', $email)
                                        ->where('social_accounts.social_id', '=', $social_id);
                              })
                              ->first();

            DB::transaction(function () use ($userSocial, &$user) {
                $socialAccount = SocialAccount::firstOrNew(
                    ['social_id' => $userSocial->getId(), 'social_provider' => 'google']
                );

                if (!($user = $socialAccount->user)) {
                    $user = User::create([
                                             'email'             => $userSocial->getEmail(),
                                             'name'              => $userSocial->getName(),
                                             'image'             => $userSocial->getAvatar(),
                                             'status'            => StatusConstant::ACTIVE,
                                             'password'          => $userSocial->getId(),
                                             'email_verified_at' => Carbon::now()->toDateTimeString(),
                                         ]);
                    $socialAccount->fill(['user_id' => $user->id])->save();
                }
            });

            // tao za access_token
            $accessToken = $user->createToken('Personal Access Token')->accessToken;

            return response()->json([
                                        'access_token' => $accessToken,
                                        'google_user'  => $userSocial,
                                    ]);

        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }

    }
}
