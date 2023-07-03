<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


// For Personal access token
Route::post('/generate/token', [ App\Http\Controllers\AccessTokenController::class , 'generate']);
Route::post('/access/token', [ App\Http\Controllers\AccessTokenController::class , 'accessToken']);



// For Company
Route::post('fetch/company', [ App\Http\Controllers\CompanyController::class , 'fetch']);
Route::post('create/company', [ App\Http\Controllers\CompanyController::class , 'create']);
Route::post('update/company', [ App\Http\Controllers\CompanyController::class , 'update']);
Route::post('destroy/company', [ App\Http\Controllers\CompanyController::class , 'destroy']);


// For Shop
Route::post('fetch/shop', [ App\Http\Controllers\ShopController::class , 'fetch']);
Route::post('create/shop', [ App\Http\Controllers\ShopController::class , 'create']);
Route::post('update/shop', [ App\Http\Controllers\ShopController::class , 'update']);
Route::post('destroy/shop', [ App\Http\Controllers\ShopController::class , 'destroy']);


