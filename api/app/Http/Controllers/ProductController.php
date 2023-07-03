<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductType;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function fetch()
    {
        $products = Product::all();

        return response()->json(["success" => true, $products]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        // return response()->json($request);
        // exit;

        $product = new Product();
        $product->name = $request->input('name');
        $product->product_type = $request->input('product_type');
        $product->price = $request->input('price');
        $product->coupon = $request->input('coupon');
        $product->status = $request->input('status');
        $product->shop_id = $request->input('shop_id');

        if ($product->save()) {
            return response()->json(['success' => true, 'message' => 'Product created successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to create product']);
        }
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $productId = $request->input('id');

        $product = Product::find($productId);

        if (!$product) {
            return response()->json(['success' => false, 'message' => 'Product not found'], 404);
        }

        $product->name = $request->input('name');
        $product->product_type = $request->input('product_type');
        $product->price = $request->input('price');
        $product->coupon = $request->input('coupon');
        $product->status = $request->input('status');
        $product->shop_id = $request->input('shop_id');

        if ($product->save()) {
            return response()->json(['success' => true, 'message' => 'Product updated successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to update product']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        $productId = $request->input('id');
        $product = Product::find($productId);
        if (!$product) {
            return response()->json(['success' => false, 'message' => 'Product not found'], 404);
        }

        if ($product->delete()) {
            return response()->json(['success' => true, 'message' => 'Product deleted successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to delete product']);
        }
    }
}
