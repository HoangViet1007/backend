<?php

namespace App\Http\Middleware;

use App\Models\ModelHasRole;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthCustomer
{
    /**
     * Handle an incoming request.
     *
     * @param Request $request
     * @param Closure $next
     *
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        // role_id = 2 customer
        $user = Auth::user();
        if($user){
            $modelHasRole = ModelHasRole::where('user_id', $user['id'])->first();
            if ($modelHasRole->role_id != 2) {
                abort(403, 'Access denied');
            }
        }else{
            abort(401, 'Unauthenticated');
        }


        return $next($request);
    }
}
