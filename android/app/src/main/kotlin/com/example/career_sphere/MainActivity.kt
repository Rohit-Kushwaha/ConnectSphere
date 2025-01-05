package com.example.career_sphere
// import android.os.Bundle
// import android.util.Log
// import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
// import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {

    private val CHANNEL = "com.example.career_sphere/root"

    // override fun configureFlutterEngine() {
    //     super.configureFlutterEngine()
    //     MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
    //         if (call.method == "isRooted") {
    //             result.success(isDeviceRooted())
    //         } else {
    //             result.notImplemented()
    //         }
    //     }
    // }

    // private fun isDeviceRooted(): Boolean {
    //     val paths = listOf(
    //         "/system/app/Superuser.apk",
    //         "/system/xbin/su",
    //         "/system/bin/su",
    //         "/system/xbin/daemonsu"
    //     )
    //     return paths.any { File(it).exists() }
    // }
}

