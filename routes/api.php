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
Route::post('/login', 'UserController@login')->name('login');
Route::get('/who-am-i', 'UserController@getCurrentUserInformation')->name('who-am-i')->middleware('auth:api');
Route::get('logout','UserController@logout')->name('logout')->middleware('auth:api');

Route::group(['prefix' => '/','middleware'=>'auth:api'], function () {

    Route::get('/redirect', 'GoogleController@redirectToProvider');
    Route::get('/callback', 'GoogleController@handleProviderCallback');
    // BMI
    Route::get('BMI', 'BMIController@countBMI');

    // contact
    Route::resource('contact', 'ContactController');

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
    Route::resource('specialize', 'SpecializeController');

    // specialize
    Route::resource('specialize-detail','SpecializeDetailController');

    //user
    Route::post('user_pt', 'UserController@addUserHasRolePt');
    Route::post('user_customer', 'UserController@addUserHasRoleCustomer');
    Route::resource('user', 'UserController');

    // course
    Route::get('course/pt','CourseController@getCourseCurrentPt');
    Route::get('course/pt/{id}','CourseController@getCourseCurrentPtById');
    Route::resource('course','CourseController');

    // Stage of PT and Admin
    Route::get('stage/{id}', 'StageController@listStage');
    Route::post('stage', 'StageController@addStage');
    Route::put('stage/{id}', 'StageController@editStage');
    Route::delete('stage/{id}', 'StageController@deleteStage');
    Route::get('detail-stage/{id}', 'StageController@detailStage');

    // Course_Planes
    Route::get('course_planes/{id}','CoursePlansController@listCoursePlanes');
    Route::post('course_planes','CoursePlansController@addCoursePlanes');
    Route::put('course_planes/{id}', 'CoursePlansController@editCoursePlanes');
    Route::delete('course_planes/{id}', 'CoursePlansController@deleteCoursePlanes');
    Route::get('detail-course_planes/{id}', 'CoursePlansController@detailCoursePlanes');
});

