<?php

namespace App\Http\Controllers;

use App\Models\Shop;
use App\Models\Company;
use Illuminate\Http\Request;
use App\Http\Requests\StoreCompanyRequest;
use App\Http\Requests\UpdateCompanyRequest;

class ShopController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function fetch()
    {
        $shops = Shop::all();

        return response()->json(["success" => true, $shops]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        // return response()->json($request);
        // exit;

        $shop = new Shop();
        $shop->name = $request->input('name');
        $shop->company_id = $request->input('company_id');

        if (empty($shop->company_id)) {
            return response()->json(['success' => false, 'message' => 'Failed to company shop'], 404);
        }

        if ($shop->save()) {
            return response()->json(['success' => true, 'message' => 'Shop created successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to create shop']);
        }
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $shopId = $request->input('id');

        $shop = Shop::find($shopId);

        if (!$shop) {
            return response()->json(['success' => false, 'message' => 'Shop not found'], 404);
        }
        $shop->name = $request->input('name');
        $shop->company_id = $request->input('company_id');

        $shop->save();

        if ($shop->save()) {
            return response()->json(['success' => true, 'message' => 'Shop updated successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to update shop']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        $shopId = $request->input('id');
        $shop = Shop::find($shopId);
        if (!$shop) {
            return response()->json(['success' => false, 'message' => 'Shop not found'], 404);
        }

        if ($shop->delete()) {
            return response()->json(['success' => true, 'message' => 'Shop deleted successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to delete shop']);
        }
    }
}
