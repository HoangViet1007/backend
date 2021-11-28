<?php

namespace App\Http\Middleware;

use App\Exceptions\ForbiddenException;
use App\Models\ModelHasRole;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthPt
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
        // role_id = 3 pt
        $user = Auth::user();
        $modelHasRole = ModelHasRole::where('user_id', $user['id'])->first();
        if ($modelHasRole->role_id != 3) {
            abort(403, 'Access denied');
        }

        return $next($request);
    }
}
