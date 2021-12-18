<?php

namespace App\Http\Middleware;

use App\Constants\StatusConstant;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class checkStatusUser
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $user = Auth::user();
        if($user['status'] == StatusConstant::INACTIVE){
            abort(403, 'Access denied');
        }
        return $next($request);
    }
}
