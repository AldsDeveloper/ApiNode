<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Shop;
use App\Models\Coupons;
use App\Models\Product;
use App\Models\ProductType;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Http\Requests\StoreProductRequest;
use App\Http\Requests\UpdateProductRequest;

class ProductController extends Controller
{

    /**
     * Show the form for creating a new resource.
     */
    public function calculateProposal(Request $request)
    {
        $totalPrice = $request->input('price');
        $discount = $request->input('discount');

        if (isset($totalPrice) and (isset($discount))) {
            $subtotal = $totalPrice - $discount;
            $tax = $subtotal * 0.07;
            $total = $subtotal + $tax;

            $response = [
                'ราคา' => $totalPrice,
                'ส่วนลด' => $discount,
                'ราคาหลังส่วนลด' => $subtotal,
                'ภาษี' => "7%",
                'ภาษีมูลค่าเพิ่มรวมยอด' => $tax,
                'ราคารวมสุทธิ' => $total
            ];

            return response()->json(["success" => true, "ผลการคำนวนใยเสนอราคา" => $response]);
        }
        return response()->json(["success" => false,  "ผลลัพธ์" => "กรุณาระบุขอมูลให้ครบถ้วน"]);
    }







    public function productPerShop(Request $request)
    {
        $status = $request->input('status');
        $coupon = $request->input('coupon');
        $shopName = $request->input('shop_name');

        // Paramiters is required : shop name , status
        if ((isset($shopName) && $status === 'active') and (!isset($coupon))) {
            $products = Product::select('products.*', 'shops.name as shop_name')
                ->leftJoin('shops', 'products.shop_id', '=', 'shops.id')
                ->where('products.status', 'active')
                ->where('shops.name', $shopName)
                ->get();

            if (!$products->isEmpty()) {
                return response()->json(["success" => true, "data" => $products]);
            } else {
                return response()->json(["success" => false, "message" => "Products not found for the given shop and status"]);
            }
        }

        // Paramiters is required : coupon = true , status
        if (($coupon && $status === 'active') and (!isset($shopName))) {
            $products = Product::select('products.*', 'coupons.numerate')
                ->leftJoin('coupons', 'products.coupon', '=', 'coupons.id')
                ->get();

            if (!$products->isEmpty()) {
                $products->each(function ($product) {
                    if ($product->coupon) {
                        $product->price_with_discount = $product->price - ($product->price * $product->numerate / 100);
                    }
                });

                return response()->json(["success" => true, "data" => $products]);
            } else {
                return response()->json(["success" => false, "message" => "Products not found"]);
            }
        }


        // Paramiters is required : shop name , coupon = true , status
        if (($coupon && $status === 'active') && (isset($shopName))) {

            if ($coupon && $status && isset($shopName)) {
                if ($status === 'active') {
                    $productsQuery = Product::select('products.*', 'coupons.numerate', 'shops.name as shop_name')
                        ->leftJoin('coupons', 'products.coupon', '=', 'coupons.id')
                        ->leftJoin('shops', 'products.shop_id', '=', 'shops.id')
                        ->where('products.status', 'active')
                        ->where('shops.name', $shopName);
                } else {
                    $productsQuery = Product::select('products.*', 'coupons.numerate', 'shops.name as shop_name')
                        ->leftJoin('coupons', 'products.coupon', '=', 'coupons.id')
                        ->leftJoin('shops', 'products.shop_id', '=', 'shops.id')
                        ->where('products.status', $status)
                        ->where('shops.name', $shopName);
                }

                $products = $productsQuery->get();

                if (!$products->isEmpty()) {
                    $products->each(function ($product) {
                        if ($product->coupon) {
                            $product->price_with_discount = $product->price - ($product->price * $product->numerate / 100);
                        }
                    });

                    return response()->json(["success" => true, "data" => $products]);
                } else {
                    return response()->json(["success" => false, "message" => "Products not found for the given coupon, status, and shop"]);
                }
            }
        }


        //Show all option // dont required params
        $products = DB::table('products')
            ->join('shops', 'products.shop_id', '=', 'shops.id')
            ->join('product_types', 'products.product_type', '=', 'product_types.id')
            ->leftJoin('coupons', 'products.coupon', '=', 'coupons.id')
            ->select('products.*', 'shops.name as shop_name', 'product_types.name as product_type_name', 'coupons.numerate')
            ->where('products.status', 'active')
            ->get();

        $products->transform(function ($product) {
            $product->price_with_coupon = $product->price - ($product->price * $product->numerate / 100);
            $product->price = floatval($product->price);
            $product->due_date = Carbon::parse($product->due_date)->format('d/m/Y');
            return $product;
        });

        if (!$products->isEmpty()) {
            return response()->json(["success" => true, "data" => $products]);
        } else {
            return response()->json(["success" => false, "message" => "No active products found"]);
        }
    }


    /**
     * Update the specified resource in storage.
     */
    public function updateStatusAll(Request $request)
    {
        $shopName = $request->input('shop_name');
        $status = $request->input('status');

        $shop = Shop::where('name', $shopName)->first();

        if ($shop) {
            $products = Product::where('shop_id', $shop->id)->update(['status' => $status]);

            if ($products) {
                return response()->json(['success' => true, 'message' => 'Product status updated successfully']);
            } else {
                return response()->json(['success' => false, 'message' => 'Failed to update product status']);
            }
        } else {
            return response()->json(['success' => false, 'message' => 'Shop not found']);
        }
    }

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
        $product->product_type = $request->input('type');
        $product->price = $request->input('price');
        $product->coupon = $request->input('coupon');
        $product->status = $request->input('status');
        $product->shop_id = $request->input('shop_id');
        $product->due_date = date('Y-m-d');
        $product->due_time = date('H:i:s');


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
        $product->product_type = $request->input('type');
        $product->price = $request->input('price');
        $product->coupon = $request->input('coupon');
        $product->status = $request->input('status');
        $product->shop_id = $request->input('shop_id');
        $product->due_date = date('Y-m-d');
        $product->due_time = date('H:i:s');

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
