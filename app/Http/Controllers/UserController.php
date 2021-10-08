<?php

namespace App\Http\Controllers;

use App\Constants\RoleConstant;
use App\Exceptions\BaseException;
use App\Models\Role;
use App\Services\BaseService;
use App\Services\UserService;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;

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
     * @return \Illuminate\Http\JsonResponse
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
     * @param \Illuminate\Http\Request $request
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
     * @param \Illuminate\Http\Request $request
     * @param int                      $id
     *
     * @return JsonResponse
     */
    public function update(Request $request, $id): JsonResponse
    {
        return response()->json($this->service->update($id,$request));
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
            'password.required' => 'Hãy nhập mật khẩu !',
            'password.min'      => 'Mật khẩu phải tối thiểu 6 kí tự !',
        ];
        $this->service->doValidate($request, $rules, $messages);

        // authen
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
                                    'token_type' => 'Bearer',
                                    'expires_at' => Carbon::parse(
                                        $tokenResult->token->expires_at
                                    )->toDateTimeString()
                                ]);
    }

    public function logout(Request $request)
    {
        if (Auth::check()) {
            $request->user()->token()->revoke();
            return response()->json([
                                        'message' => 'Đăng xuất thành công !'
                                    ]);
        } else {
            return false ;
        }
    }
}
