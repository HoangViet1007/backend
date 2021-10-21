<?php

namespace App\Http\Controllers;

use App\Constants\RoleConstant;
use App\Constants\StatusConstant;
use App\Exceptions\SystemException;
use App\Models\ModelHasRole;
use App\Models\Role;
use App\Models\SocialAccount;
use App\Models\User;
use App\Services\BaseService;
use App\Services\UserService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Laravel\Socialite\Facades\Socialite;
use Symfony\Component\HttpKernel\Exception\HttpException;

class GoogleController extends Controller
{
    public             $roleConstant = RoleConstant::ALL;
    public BaseService $service;

    public function __construct()
    {
        $this->service = new UserService();
    }

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
                                        'google_user'  => $userSocial,
                                    ]);
        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }
    }

    public function loginAccountGoogle(Request $request): JsonResponse
    {
        $service = new UserService();
        $service->doValidate($request,
                             [
                                 'access_token' => 'required',
                                 'role'         => 'required|in:' . implode(',', $this->roleConstant),
                             ],
                             [
                                 'access_token.required' => 'Hãy nhập access_token !',
                                 'role.required'         => 'Hãy nhập chức vụ !',
                                 'role.in'               => 'Chức vụ không hợp lệ !',
                             ]
        );

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
            // check khi đăng nhập pt vs customer cùng một email thì ko đc
            //check role truyền lên với role của user trong hệ thông có trùng nhau hay ko
            // nếu có thi true nếu ko thì false

            // lấy za role_id của user trong he thong
            $modelHasRole = ModelHasRole::where('user_id', $user->user_id)->first();
            // lấy za name role
            $role = Role::find($modelHasRole->role_id);
            if ($role->name != $request->role) {
                // throw new SystemException('Đăng nhập thất bại !' ?? __('system-500'));
                throw new HttpException(500, 'Đăng nhập thất bại !');
            }

            DB::transaction(function () use ($userSocial, &$user, $request) {
                $socialAccount = SocialAccount::firstOrNew(
                    ['social_id' => $userSocial->getId(), 'social_provider' => 'google']
                );

                if (!($user = $socialAccount->user)) {
                    $this->service->doValidate($request,
                                               ['email' => 'unique:users,email'],
                                               ['email.unique' => 'Email này đã tồn tại !']
                    );
                    $user = User::create([
                                             'email'             => $userSocial->getEmail(),
                                             'name'              => $userSocial->getName(),
                                             'image'             => $userSocial->getAvatar(),
                                             'status'            => StatusConstant::ACTIVE,
                                             'password'          => $userSocial->getId(),
                                             'email_verified_at' => Carbon::now()->toDateTimeString(),
                                         ]);
                    $socialAccount->fill(['user_id' => $user->id])->save();

                    // add role cho user
                    if (isset($request->role)) {
                        $role = Role::where('name', $request->role)->first();
                        DB::table('model_has_roles')->insert(['role_id' => $role->id, 'user_id' => $user->id]);
                    }
                }
            });

            // tao za access_token
            $accessToken = $user->createToken('Personal Access Token')->accessToken;

            return response()->json([
                                        'access_token' => $accessToken,
                                        'user'         => $user,
                                    ]);

        } catch (Exception $e) {
            throw new SystemException($e->getMessage() ?? __('system-500'), $e);
        }

    }
}
