<?php

namespace App\Http\Controllers;

use App\Models\ProductType;
use Illuminate\Http\Request;
use App\Http\Requests\StoreProductTypeRequest;
use App\Http\Requests\UpdateProductTypeRequest;

class ProductTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function fetch()
    {
        $shops = ProductType::all();

        return response()->json(["success" => true, $shops]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        // return response()->json($request);
        // exit;

        $type = new ProductType();
        $type->name = $request->input('name');

        if ($type->save()) {
            return response()->json(['success' => true, 'message' => 'Product type created successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to create product type']);
        }
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $shopId = $request->input('id');

        $shop = ProductType::find($shopId);

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
        $shop = ProductType::find($shopId);
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
