<?php

use Illuminate\Http\Request;
use App\Http\Controllers\DemoController ;
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
Route::resource('/demo', 'DemoController');
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

Route::get('/send-email','StageController@sendEmail');
// api clien
Route::group(['prefix' => '/'], function () {
    // register customer and pt
    Route::post('user_pt', 'UserController@addUserHasRolePt');
    Route::post('user_customer', 'UserController@addUserHasRoleCustomer');

    // BMI
    Route::get('BMI', 'BMIController@countBMI');

    // contact
    Route::resource('contact', 'ContactController');

    // get course noi bat
    Route::get('list-course','CourseController@getCourse');

    // get course by id in client
    Route::get('course-detail/client/{id}','CourseController@getCourseByIdInClient');

    // get customer level cho list course in client
    Route::get('list-customer-level','CustomerLevelController@getCustomerLevel');

    // get all chuyên môn cho list khoá học client
    Route::get('list-specialize-for-client','SpecializeController@getSpecializeForClient');

});

Route::group(['prefix' => '/', 'middleware' => 'auth:api'], function () {
    Route::get('/who-am-i', 'UserController@getCurrentUserInformation');

    // setting
    Route::resource('setting', 'SettingController');

    // customer_level
    Route::resource('customer_level', 'CustomerLevelController');

    // Certificates of PT and Admin
    Route::resource('certificates', 'CertificateController');

    Route::get('get-list-certificates-specialize/{id}', 'CertificateController@listCertificatesSpecialize');
    // slide
    Route::resource('slide', 'SlideController');

    // specialize
    Route::get('specialize/select-option/', 'SpecializeController@getAllUseSelectOption');
    Route::resource('specialize', 'SpecializeController');

    // specialize
    Route::get('specialize-detail/select-option/', 'SpecializeDetailController@getAllUseSelectOption');
    Route::get('specialize-detail/pt', 'SpecializeDetailController@getAllByPt');
    Route::get('specialize-detail/pt/{id}', 'SpecializeDetailController@showByPt');
    Route::delete('specialize-detail/pt/{id}', 'SpecializeDetailController@destroyByPt');
    Route::resource('specialize-detail', 'SpecializeDetailController');

    //user
    Route::post('update-password','UserController@updatePassword');
    Route::put('user-edit/{id}', 'UserController@editUser');
    Route::resource('user', 'UserController');

    // course
    Route::put('/course/display/{id}','CourseController@updateDisplay');
    Route::get('course/pt/all', 'CourseController@getAllCourseCurrentPtNoPaginate');
    Route::get('course/pt', 'CourseController@getCourseCurrentPt');
    Route::get('course/pt/{id}', 'CourseController@getCourseCurrentPtById');
    Route::put('course/pt/{id}', 'CourseController@updateCourseForAdmin');
    Route::resource('course', 'CourseController');

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

    // account level
    Route::get('account-level/select-option/', 'AccountLevelController@getAllUseSelectOption');
    Route::resource('account-level', 'AccountLevelController');

    // role
    Route::resource('role','RoleController');

    // course student
    Route::post('customer-cancel/{id}','CourseStudentController@customerCancel');
    Route::post('pt-cancel/{id}','CourseStudentController@ptCancel');
    Route::resource('course_student','CourseStudentController');
});

