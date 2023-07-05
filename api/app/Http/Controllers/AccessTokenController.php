<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Laravel\Passport\HasApiTokens;
use Illuminate\Support\Facades\Auth;
use Laravel\Sanctum\PersonalAccessToken;


class AccessTokenController extends Controller
{
    public function generate(Request $request)
    {
        $payload = $request->json()->all();
        $credentials = ['email' => $payload['email'] , 'password' => $payload['password']];

        if (Auth::attempt($credentials)) {

            $user = Auth::user();
            $token = $user->createToken('API Access Token')->accessToken;
            $user->remember_token = $token->token;
            $user->save();

            return response()->json(['success' => true, 'token' => $token['token']], 200);
        }

        return response()->json(['success' => false, 'error' => 'Generate token is fials'], 401);
    }


    public function accessToken(Request $request)
    {
        $accessToken = $request->header('Authorization');
        $accessToken = str_replace('Bearer ', '', $accessToken);

        $personalAccessToken = PersonalAccessToken::where('token', $accessToken)->first();

        if ($personalAccessToken) {
            // ตรวจสอบ Token สำเร็จ
            return response()->json(['success' => true, 'message' => 'Valid Token'], 200);
        } else {
            // Token ไม่ถูกต้องหรือไม่มีอยู่ในฐานข้อมูล
            return response()->json(['success' => false, 'message' => 'Invalid Token'], 401);
        }
    }
}
