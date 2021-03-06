<?php

namespace App\Http\Controllers;

use App\Constants\AccountLevelConstant;
use App\Constants\ActionConstant;
use App\Constants\PermissionConstant;
use App\Constants\RoleConstant;
use App\Exceptions\ForbiddenException;
use App\Models\AccountLevel;
use App\Models\Role;
use App\Services\BaseService;
use App\Services\UserService;
use App\Trait\RoleAndPermissionTrait;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Laravel\Passport\Client as OClient;

class UserController extends Controller
{
    public BaseService $service;

    use RoleAndPermissionTrait;
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

        $account_level    = AccountLevel::where('name', AccountLevelConstant::ACCOUNT_LEVEL_DEFAULT)->first();
        $account_level_id = $account_level->id;

        return response()->json($this->service->addUser($request, $role_ids, $account_level_id));
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
        if (!$this->hasPermission(PermissionConstant::user(ActionConstant::ADD)))
            throw new ForbiddenException(__('Access denied'), new Exception());

        $data     = Role::where('name', RoleConstant::CUSTOMER)->first();
        $role_ids = [$data->id];

        $account_level_id = $request->account_level_id ?? null;

        return response()->json($this->service->addUser($request, $role_ids, $account_level_id));
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
            'email.required'    => 'H??y nh???p ?????a ch??? email !',
            'email.email'       => '?????a ch??? email kh??ng h???p l?? !',
            'password.required' => 'H??y nh???p m???t kh???u !',
            'password.min'      => 'M???t kh???u ph???i t???i thi???u 6 k?? t??? !',
        ];
        $this->service->doValidate($request, $rules, $messages);

        // authentication
        $credentials = request(['email', 'password']);
        if (!Auth::attempt($credentials)) {
            return response()->json([
                                        'message' => 'M???t kh???u ho???c t??i kho???n kh??ng ch??nh x??c !'
                                    ], 400);
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
                                    'user'         => $user
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
            'email.required'    => 'H??y nh???p ?????a ch??? email !',
            'email.email'       => '?????a ch??? email kh??ng h???p l?? !',
            'password.required' => 'H??y nh???p m???t kh???u !',
            'password.min'      => 'M???t kh???u ph???i t???i thi???u 6 k?? t??? !',
        ];
        $this->service->doValidate($request, $rules, $messages);

        // authentication
        $credentials = request(['email', 'password']);
        if (!Auth::attempt($credentials)) {
            return response()->json([
                                        'message' => 'M???t kh???u ho???c t??i kho???n kh??ng ch??nh x??c !'
                                    ], 401);
        }
        // check them role

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
                                   ['refresh_token' => 'H??y nh???p refresh-token ????? gia h???n ????ng nh???p !']
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
                                    'message' => '????ng xu???t th??nh c??ng !'
                                ]);

    }

    public function updatePassword(Request $request): JsonResponse
    {
        return response()->json($this->service->updatePassword($request));
    }

    public function getPassword(Request $request){
        return response()->json($this->service->getPassword($request));

    }
}
