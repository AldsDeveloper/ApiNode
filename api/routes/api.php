<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\CompanyController;
use App\Http\Controllers\AccessTokenController;

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


// For Personal access token For Nodejs
Route::post('/generate/token', [ App\Http\Controllers\AccessTokenController::class , 'generate']);
Route::post('/access/token', [ App\Http\Controllers\AccessTokenController::class , 'accessToken']);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


// For Product
Route::post('fetch/product/active', [ App\Http\Controllers\ProductController::class , 'productPerShop']);


// For Companies
Route::post('fetch/company', [ App\Http\Controllers\CompanyController::class , 'fetch']);
Route::post('create/company', [ App\Http\Controllers\CompanyController::class , 'create']);
Route::post('update/company', [ App\Http\Controllers\CompanyController::class , 'update']);
Route::post('destroy/company', [ App\Http\Controllers\CompanyController::class , 'destroy']);


// For Shops
Route::post('fetch/shop', [ App\Http\Controllers\ShopController::class , 'fetch']);
Route::post('create/shop', [ App\Http\Controllers\ShopController::class , 'create']);
Route::post('update/shop', [ App\Http\Controllers\ShopController::class , 'update']);
Route::post('destroy/shop', [ App\Http\Controllers\ShopController::class , 'destroy']);

// For Coupons
Route::post('fetch/coupon', [ App\Http\Controllers\CouponsController::class , 'fetch']);
Route::post('create/coupon', [ App\Http\Controllers\CouponsController::class , 'create']);
Route::post('update/coupon', [ App\Http\Controllers\CouponsController::class , 'update']);
Route::post('destroy/coupon', [ App\Http\Controllers\CouponsController::class , 'destroy']);

// For Product
Route::post('fetch/product', [ App\Http\Controllers\ProductController::class , 'fetch']);
Route::post('create/product', [ App\Http\Controllers\ProductController::class , 'create']);
Route::post('update/product', [ App\Http\Controllers\ProductController::class , 'update']);
Route::post('destroy/product', [ App\Http\Controllers\ProductController::class , 'destroy']);


// For Product Type
Route::post('fetch/product/type', [ App\Http\Controllers\ProductTypeController::class , 'fetch']);
Route::post('create/product/type', [ App\Http\Controllers\ProductTypeController::class , 'create']);
Route::post('update/product/type', [ App\Http\Controllers\ProductTypeController::class , 'update']);
Route::post('destroy/product/type', [ App\Http\Controllers\ProductTypeController::class , 'destroy']);


