<?php

use Illuminate\Http\Request;
use App\Http\Controllers\DemoController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::get('/demo', 'DemoController@demo');
// login cho tk thuong
Route::post('/login', 'UserController@login')->name('login');
// login cho tk google
Route::post('/login/google', 'GoogleController@loginAccountGoogle')->name('loginGoogle');
// login cho tk thuong co refresh token
Route::post('/loginVPS', 'UserController@loginVPS')->name('loginVPS');
// khi het han login truyen refretoken de gia han
Route::post('/refresh-token', 'UserController@refreshToken');
Route::get('logout', 'UserController@logout')->name('logout')->middleware('auth:api');
// redirect va callback acount gg
Route::get('/redirect', 'GoogleController@redirectToProvider');
Route::get('/callback', 'GoogleController@handleProviderCallback');

Route::get('/send-email', 'StageController@sendEmail');
// gửi email thông báo lịch học
Route::get('/send-email-student', 'StageController@sendEmailStudent');
// hủy khóa học
Route::get('/send-email-cancel-course', 'StageController@sendEmailCancelStudent');
// PT không thể dạy khóa học đấy
Route::get('/send-email-pt-cant-teach', 'StageController@ptCantTeach');

// Học viên xin nghỉ buổi học
Route::get('/send-email-custorm-dont-study', 'StageController@CustormCancel');
//SuccessfulCourseBrowsing
// PT duyệt học viên
Route::get('/send-email-successful-course-browsing', 'StageController@SuccessfulCourseBrowsing');

// xác thực email CustormCancel

Route::post('/email/verification-notification', 'EmailVerificationController@sendEmailVerification')
    ->middleware('auth:api')
    ->name('verification.send');

// check verify email
Route::get('/verify-email/{id}/{hash}', 'EmailVerificationController@verify')
    ->middleware('auth:api')
    ->name('verification.verify');
// api clien

Route::get('/check-add-user-verify', 'EmailVerificationController@addUserVerify');


Route::post('/get-password', 'UserController@getPassword');


// get schedule PT and Custorm

Route::get('/get-schedule', 'ScheduleController@scheduleCustormAndPT');
Route::get('/get-schedules', 'ScheduleController@getCalenderCustomer');



Route::group(['prefix' => '/'], function () {
    // register customer and pt
    Route::post('user_pt', 'UserController@addUserHasRolePt');
    Route::post('user_customer', 'UserController@addUserHasRoleCustomer');

    // BMI
    Route::post('BMI', 'BMIController@countBMI');

    // contact
    Route::resource('contact', 'ContactController');

    // get course noi bat
    Route::get('list-course', 'CourseController@getCourse');

    // get course by id in client
    Route::get('course-detail/client/{id}', 'CourseController@getCourseByIdInClient');

    // get customer level cho list course in client
    Route::get('list-customer-level', 'CustomerLevelController@getCustomerLevel');

    // get all chuyên môn cho list khoá học client
    Route::get('list-specialize-for-client', 'SpecializeController@getSpecializeForClient');

    // get list pt in client
    Route::get('/get-list-pt-client','ClientController@getListPtClient');

// trang chủ
    Route::get('trang-chu', 'ClientController@index');

    // chi tiết PT
    Route::get('detail-pt/{id}','ClientController@detailPT');

    // get setting in client
    Route::get('get-setting-client','ClientController@getSettingClient');



});

// admin
Route::group(['prefix' => '/', 'middleware' => 'auth:api','checkStatusUser', 'verified_custom'], function () {

    // setting
    Route::resource('setting', 'SettingController');

    //conatct
    Route::get('get-list-contact','ContactController@index');
    Route::post('send-email-contact','ContactController@sendEmailContact');

    // customer_level
    Route::resource('customer_level', 'CustomerLevelController');

    // slide
    Route::resource('slide', 'SlideController');

    // role
    Route::resource('role', 'RoleController');

    // permission
    Route::post('permission-import', 'PermissionController@import');
    Route::get('permission-export', 'PermissionController@export');
    Route::get('permission-nopaginate', 'PermissionController@getAllPermissionNoPaginate');
    Route::get('get-all-permission', 'PermissionController@getAllPermission');
    Route::resource('permission', 'PermissionController');

    // specialize
    Route::resource('specialize', 'SpecializeController');

    // account level
    Route::resource('account-level', 'AccountLevelController');

    // complain in admin
    Route::get('list-complain', 'ScheduleAdminController@listComplain');
    Route::put('change-complain', 'ScheduleAdminController@changeComplain');

    // user and pt đều dùng để sửa status khoá học
    Route::put('course/pt/{id}', 'CourseController@updateCourseForAdmin');

    // bill
    Route::resource('bill', 'BillController');

    // payment
    Route::resource('payment', 'PaymentController');

    // user
    Route::resource('user', 'UserController');


    // list course in admin
    Route::get('get-course-request', 'CourseController@getCourseRequest');

    Route::resource('bill-personal-trainer', 'BillPersonalTrainerController'); // ở Admin

    Route::get('get-request-admin-for-admin', 'CourseStudentController@getCourseStudentRequestAdminForAdmin'); // ở Admin

    // danh sách comment của PT
    Route::get('list-comment', 'CommentController@listComment');

    // thay đổi status của comment
    Route::post('change-status-comment', 'CommentController@changeStatus');

   // dashboard admin
    Route::get('dashboard-admin','DashboardController@DashboardAdmin');

    // list course student
    Route::get('get-all-course-student','CourseStudentController@getAllCourseStudent');
});

// pt
Route::group(['prefix' => '/', 'middleware' => ['auth:api', 'authPt','checkStatusUser', 'verified_custom']], function () {
    // Certificates of PT and Admin
    Route::get('get-list-certificates-specialize/{id}', 'CertificateController@listCertificatesSpecialize');
    Route::resource('certificates', 'CertificateController');

    // specialize-detail
    Route::get('specialize-detail/select-option/', 'SpecializeDetailController@getAllUseSelectOption');
    Route::get('specialize-detail/pt', 'SpecializeDetailController@getAllByPt');
    Route::get('specialize-detail/pt/{id}', 'SpecializeDetailController@showByPt');
    Route::delete('specialize-detail/pt/{id}', 'SpecializeDetailController@destroyByPt');
    Route::resource('specialize-detail', 'SpecializeDetailController');

    // Stage of PT and Admin
    Route::get('stage-of-course/{id}', 'StageController@listStage');
    Route::post('stage', 'StageController@addStage');
    Route::put('stage/{id}', 'StageController@editStage');
    Route::delete('stage/{id}', 'StageController@deleteStage');
    Route::get('detail-stage/{id}', 'StageController@detailStage');

    // Course_Planes
    Route::get('course_planes-of-stage/{id}', 'CoursePlansController@listCoursePlanes');
    Route::post('course_planes', 'CoursePlansController@addCoursePlanes');
    Route::put('course_planes/{id}', 'CoursePlansController@editCoursePlanes');
    Route::delete('course_planes/{id}', 'CoursePlansController@deleteCoursePlanes');
    Route::get('detail-course_planes/{id}', 'CoursePlansController@detailCoursePlanes');

    //course
    Route::get('/cancel-request-course/{id}', 'CourseController@cancelRequestCourse');
    Route::get('/request-course/{id}', 'CourseController@requestCourse');
    Route::get('get-course-plan-off-by-course/{id}', 'CourseController@getCoursePlanOff');
    Route::put('/course/display/{id}', 'CourseController@updateDisplay');
    Route::get('course/pt/all', 'CourseController@getAllCourseCurrentPtNoPaginate');
    Route::get('course/pt', 'CourseController@getCourseCurrentPt');
    Route::get('course/pt/{id}', 'CourseController@getCourseCurrentPtById');
    Route::resource('course', 'CourseController');

    // course student
    Route::get('get-request-admin-for-pt-by-id/{id}', 'CourseStudentController@getCourseStudentById'); // ở PT
    Route::get('get-request-admin-for-pt', 'CourseStudentController@getCourseStudentRequestAdminForPt'); // ở PT
    Route::get('sent-request-customer/{id}', 'CourseStudentController@sentRequestCustomer');
    Route::resource('course_student', 'CourseStudentController');
    Route::post('pt-cancel/{id}', 'CourseStudentController@ptCancel');
    Route::put('pt-through/{id}', 'CourseStudentController@ptThough');
    Route::put('send-admin-through/{id}', 'CourseStudentController@sendAdminThrough');

    // schedule
    Route::post('schedule-repeat', 'ScheduleController@scheduleRepeat');
    Route::resource('schedule', 'ScheduleController');
    Route::get('get-calender-work-pt', 'ScheduleController@getCalenderPt');
    Route::put('update-record-schedule/{id}', 'ScheduleController@updateRecord');
    Route::get('get-schedule-by-course-student/{id}', 'ScheduleController@getScheduleByCourseStudent');
    Route::put('update-status-schedule-complete/{id}', 'ScheduleController@updateStatusScheduleComplete');
    Route::put('start-schedule/{id}', 'ScheduleController@startSchedule');
    Route::put('end-schedule/{id}', 'ScheduleController@endSchedule');
    Route::get('list-course-complain', 'ScheduleController@listComplainPt');


    Route::get('bill-personal-trainer-pt', 'BillPersonalTrainerController@getAllBillPtForPt'); // ở PT

// dashboard pt
    Route::get('dashboard-pt','DashboardController@DashboardPT');

});

// customer
Route::group(['prefix' => '/', 'middleware' => ['auth:api', 'authCustomer','checkStatusUser', 'verified_custom']], function () {
    // hoa don
    Route::get('hoa-don', 'BillController@listBillByCustomer');

    // thanh toan
    Route::post('thanh-toan', 'PaymentController@createPayment');
    Route::post('thanh-toan/thong-bao', 'PaymentController@returnPayment');

    Route::get('khach-hang/payment', 'PaymentController@listPaymentByCustomer');

    // course_student customer
    Route::post('customer-cancel/{id}', 'CourseStudentController@customerCancel');

    // bảo fe sửa call lại api
    Route::get('get-course_student/customer', 'CourseStudentController@getCourseForCustomer');

    Route::get('user-agrees-course-student/{id}', 'CourseStudentController@userAgreesCourseStudent');
    Route::get('user-dis-agrees-course-student/{id}', 'CourseStudentController@userDisAgreesCourseStudent');
    Route::get('get-course_plan-by-course-student/{id}', 'CourseStudentController@getCoursePlanByCourseStudent');

    //schedule customer
    Route::get('get-calender-work-customer', 'ScheduleController@getCalenderCustomer');

    // schedule repeat
    Route::put('not-engaged/{id}', 'ScheduleController@notEngaged');
    Route::put('engaged/{id}', 'ScheduleController@engaged');
    Route::put('complanin/{id}', 'ScheduleController@complanin');
    Route::put('cancel-complain/{id}', 'ScheduleController@cancelComplain');
    Route::get('get-complain-for-customer', 'ScheduleController@getComplainForCustomer');
    Route::get('get-schedule-by-customer/{id}', 'ScheduleController@getScheduleByCustomer');

    // dashboard customer
    Route::get('dashboard-customer','DashboardController@DashboardCustomer');
});

Route::group(['prefix' => '/', 'middleware' => 'auth:api','checkStatusUser'], function () {
    Route::get('/who-am-i', 'UserController@getCurrentUserInformation');
    //user
    Route::post('update-password', 'UserController@updatePassword');// car hai cai deu dung pt vaf cusstomer
    Route::put('user-edit/{id}', 'UserController@editUser');

    Route::get('account-level-select-option/', 'AccountLevelController@getAllUseSelectOption'); // viet them ow pt
    Route::get('specialize-select-option/', 'SpecializeController@getAllUseSelectOption'); // viet them owr pt

    // dang ki khoa học course_student // fe call lại
    Route::post('course_student-post', 'CourseStudentController@store');

    // get all social
    Route::get('get-all-social', 'SocialController@getAll');

    // add comment
    Route::post('add-comment', 'CommentController@addComment');


});

Route::get('email/verify/{id}', 'VerificationController@verify')->name('verification.verify');

Route::get('email/resend', 'VerificationController@resend')->name('verification.resend');

Route::get('tesst','ScheduleController@tesst');
