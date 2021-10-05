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
Route::resource('/demo', 'DemoController');
Route::group(['prefix' => '/'], function () {
    // BMI
    Route::get('BMI', 'BMIController@countBMI');

    // contact
    Route::resource('contact', 'ContactController');

    // setting
    Route::resource('setting', 'SettingController');

    // customer_level
    Route::resource('customer_level', 'CustomerLevelController');

    // certificates

    Route::resource('certificates', 'CertificateController');

    // slide
    Route::resource('slide','SlideController');

    // specialize
    Route::resource('specialize','SpecializeController');

    // specialize
    Route::resource('specialize-detail','SpecializeDetailController');
});
// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
