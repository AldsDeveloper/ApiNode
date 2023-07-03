<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreCompanyRequest;
use App\Http\Requests\UpdateCompanyRequest;
use Illuminate\Http\Request;
use App\Models\Company;

class CompanyController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function fetch()
    {
        $companies = Company::all();

        return response()->json(["success" => true, $companies]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {

        $company = new Company();
        $company->name = $request->input('name');

        if ($company->save()) {
            return response()->json(['success' => true, 'message' => 'Company created successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to create company']);
        }
    }
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $companyId = $request->input('id');
        $company = Company::find($companyId);

        if (!$company) {
            return response()->json(['success' => false, 'message' => 'Company not found'], 404);
        }
        $company->name = $request->input('name');
        $company->save();

        if ($company->save()) {
            return response()->json(['success' => true, 'message' => 'Company updated successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to update company']);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        $companyId = $request->input('id');
        $company = Company::find($companyId);
        if (!$company) {
            return response()->json(['success' => false, 'message' => 'Company not found'], 404);
        }

        if ($company->delete()) {
            return response()->json(['success' => true, 'message' => 'Company deleted successfully']);
        } else {
            return response()->json(['success' => false, 'message' => 'Failed to delete company']);
        }
    }
}
