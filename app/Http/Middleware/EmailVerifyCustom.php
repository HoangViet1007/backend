<?php

namespace App\Http\Middleware;

use App\Exceptions\BadRequestException;
use App\Models\User;
use Closure;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Auth;
use Exception;

class EmailVerifyCustom
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string|null  $redirectToRoute
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse|null
     */
    public function handle($request, Closure $next)
    {
        if(auth()->user()){
            $user = User::where('id', Auth::id())->first();
            if($user->email_verified_at === NULL)
            {
                throw new BadRequestException(
                    ['message' => __("email_verify")],
                    new Exception()
                );
            }
        }
        return $next($request);
    }
}
