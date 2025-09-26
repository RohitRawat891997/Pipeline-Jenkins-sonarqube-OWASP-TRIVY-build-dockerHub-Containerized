<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class DashboardController extends Controller
{
      public function index()
    {
         $user = DB::table('users')->get(); // ✅ U
        return view('dashboard', compact('user'));
    }
}
