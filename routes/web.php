<?php

use App\Http\Controllers\Admin\SupplierController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return redirect()->route('admin.suppliers.index');
});

Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('admin.suppliers.index');
    }
    return view('auth.login');
})->name('login');

Route::post('/login', function (Request $request) {
    $credentials = $request->validate([
        'email' => ['required', 'email'],
        'password' => ['required'],
    ]);

    if (Auth::attempt($credentials, true)) {
        $request->session()->regenerate();
        return redirect()->intended(route('admin.suppliers.index'));
    }

    return back()->withErrors([
        'email' => 'Thông tin đăng nhập không chính xác.',
    ])->onlyInput('email');
})->name('login.post');

Route::post('/logout', function (Request $request) {
    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();
    return redirect()->route('login');
})->name('logout');

Route::prefix('admin')->name('admin.')->middleware(['auth', 'admin'])->group(function () {
    Route::resource('suppliers', SupplierController::class);
    Route::get('suppliers-search', [SupplierController::class, 'searchAjax'])->name('suppliers.search');
    Route::get('suppliers/{supplier}/import', [SupplierController::class, 'importForm'])->name('suppliers.importForm');
    Route::post('suppliers/{supplier}/import', [SupplierController::class, 'processImport'])->name('suppliers.processImport');
});
