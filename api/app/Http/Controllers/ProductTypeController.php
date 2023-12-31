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
        $types = ProductType::all();

        return response()->json(["success" => true, $types]);
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
        $typeId = $request->input('id');

        $type = ProductType::find($typeId);

        if (!$type) {
            return response()->json(['success' => false, 'message' => 'Product type not found'], 404);
        }

        $type->name = $request->input('name');

        $type->save();

        if ($type->save()) {
            return response()->json(['success' => true, 'message' => 'Product type updated successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to update product type']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        $typeId = $request->input('id');
        $type = ProductType::find($typeId);
        if (!$type) {
            return response()->json(['success' => false, 'message' => 'Product Type not found'], 404);
        }

        if ($type->delete()) {
            return response()->json(['success' => true, 'message' => 'Product Type deleted successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to delete product Type']);
        }
    }
}
