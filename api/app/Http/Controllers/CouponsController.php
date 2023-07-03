<?php

namespace App\Http\Controllers;

use App\Models\Shop;
use App\Models\Coupons;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\StoreCouponsRequest;
use App\Http\Requests\UpdateCouponsRequest;

class CouponsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function fetch()
    {
        $coupons = Coupons::all();

        return response()->json(["success" => true, $coupons]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        // return response()->json($request);
        // exit;

        $coupon = new Coupons();
        $coupon->numerate = $request->input('numerate');

        if ($coupon->save()) {
            return response()->json(['success' => true, 'message' => 'Coupon created successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to create coupon']);
        }
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $couponId = $request->input('id');

        $coupon = Coupons::find($couponId);

        if (!$coupon) {
            return response()->json(['success' => false, 'message' => 'Coupon not found'], 404);
        }
        $coupon->numerate = $request->input('numerate');

        $coupon->save();

        if ($coupon->save()) {
            return response()->json(['success' => true, 'message' => 'Coupon updated successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to update coupon']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        $couponId = $request->input('id');
        $coupon = Coupons::find($couponId);
        if (!$coupon) {
            return response()->json(['success' => false, 'message' => 'Coupon not found'], 404);
        }

        if ($coupon->delete()) {
            return response()->json(['success' => true, 'message' => 'Coupon deleted successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to delete coupon']);
        }
    }
}
