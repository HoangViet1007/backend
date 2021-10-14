<?php

namespace App\Http\Controllers;

use App\Constants\RoleConstant;
use App\Models\Role;
use App\Services\BaseService;
use App\Services\UserService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Laravel\Passport\Client as OClient;

class UserController extends Controller
{
    public BaseService $service;

    public function __construct()
    {
        $this->service = new UserService();
    }

    /**
     * Display a listing of the resource.
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        return response()->json($this->service->getAll());
    }

    public function addUserHasRolePt(Request $request): JsonResponse
    {
        $data     = Role::where('name', RoleConstant::PT)->first();
        $role_ids = [$data->id];

        return response()->json($this->service->addUser($request, $role_ids));
    }

    public function addUserHasRoleCustomer(Request $request): JsonResponse
    {
        $data     = Role::where('name', RoleConstant::CUSTOMER)->first();
        $role_ids = [$data->id];

        return response()->json($this->service->addUser($request, $role_ids));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    public function store(Request $request): JsonResponse
    {
        $rules    = [
            'role_ids'   => 'nullable|array',
            'role_ids.*' => 'exists:roles,id'
        ];
        $messages = [
            'role_ids.array'    => 'Chức vụ không hợp lệ !',
            'role_ids.*.exists' => 'Chức vụ :attribute không  tồn tại !'
        ];
        $this->service->doValidate($request, $rules, $messages);
        $role_ids = $request->role_ids ?? [];
        if (count($role_ids) <= 0) {
            $data     = Role::where('name', RoleConstant::CUSTOMER)->first();
            $role_ids = [$data->id];
        }

        return response()->json($this->service->addUser($request, $role_ids));
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function show($id): JsonResponse
    {
        return response()->json($this->service->get($id));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param int     $id
     *
     * @return JsonResponse
     */
    public function update(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->update($id, $request));
    }

    public function editUser(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->editUser($id, $request));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     *
     * @return JsonResponse
     */
    public function destroy($id): JsonResponse
    {
        return response()->json($this->service->delete($id));
    }

    public function getCurrentUserInformation(Request $request): JsonResponse
    {
        return response()->json($this->service->getCurrentUserInformation($request));
    }

    public function login(Request $request)
    {
        // validate
        $rules    = [
            'email'    => 'required|email',
            'password' => 'required|min:6'
        ];
        $messages = [
            'email.required'    => 'Hãy nhập địa chỉ email !',
            'email.email'       => 'Địa chỉ email không hợp lê !',
            'password.required' => 'Hãy nhập mật khẩu !',
            'password.min'      => 'Mật khẩu phải tối thiểu 6 kí tự !',
        ];
        $this->service->doValidate($request, $rules, $messages);

        // authentication
        $credentials = request(['email', 'password']);
        if (!Auth::attempt($credentials)) {
            return response()->json([
                                        'message' => 'Mật khẩu hoặc tài khoản không chính xác !'
                                    ], 401);
        }

        // create token
        $user        = $request->user();
        $tokenResult = $user->createToken('Personal Access Token');
        $token       = $tokenResult->token;


        // check remember me
        if ($request->remember_me) {
            $token->expires_at = Carbon::now()->addWeeks(1);
        }
        $token->save();

        return response()->json([
                                    'access_token' => $tokenResult->accessToken,
                                    'token_type'   => 'Bearer',
                                    'expires_at'   => Carbon::parse(
                                        $tokenResult->token->expires_at
                                    )->toDateTimeString(),
                                    'google_user'  => $user
                                ]);
    }

    public function loginVPS(Request $request): JsonResponse
    {
        // validate
        $rules    = [
            'email'    => 'required|email',
            'password' => 'required|min:6'
        ];
        $messages = [
            'email.required'    => 'Hãy nhập địa chỉ email !',
            'email.email'       => 'Địa chỉ email không hợp lê !',
            'password.required' => 'Hãy nhập mật khẩu !',
            'password.min'      => 'Mật khẩu phải tối thiểu 6 kí tự !',
        ];
        $this->service->doValidate($request, $rules, $messages);

        // authentication
        $credentials = request(['email', 'password']);
        if (!Auth::attempt($credentials)) {
            return response()->json([
                                        'message' => 'Mật khẩu hoặc tài khoản không chính xác !'
                                    ], 401);
        }

        //create token and refresh token
        $oClient  = OClient::where('password_client', 1)->first();
        $response = Http::asForm()->post(env('HTTP') . '/oauth/token', [
            "grant_type"    => "password",
            "client_id"     => $oClient->id,
            "client_secret" => $oClient->secret,
            "username"      => $request->email,
            "password"      => $request->password,
            "scope"         => "*"
        ]);



        return response()->json([
                                    'token' => $response->json(),
                                    'user'  => Auth::user()
                                ]);
    }

    public function refreshToken(Request $request): JsonResponse
    {
        $this->service->doValidate($request,
                          ['refresh_token' => 'required'],
                          ['refresh_token' => 'Hãy nhập refresh-token để gia hạn đăng nhập !']
        );
        $oClient  = OClient::where('password_client', 1)->first();
        $response = Http::asForm()->post(env('HTTP') . '/oauth/token', [
            "grant_type"    => "refresh_token",
            'refresh_token' => $request->refresh_token,
            "client_id"     => $oClient->id,
            "client_secret" => $oClient->secret,
            "scope"         => "*",
        ]);

        return response()->json([
                                    'token' => $response->json(),
                                    'user'  => Auth::user()
                                ]);
    }


    public function logout(Request $request): JsonResponse
    {
        $request->user()->token()->revoke();

        return response()->json([
                                    'message' => 'Đăng xuất thành công !'
                                ]);

    }
}
