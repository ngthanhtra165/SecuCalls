package com.example.secucalls;

import android.Manifest;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.telecom.Call;
import android.telecom.TelecomManager;
import android.content.Context;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "call_handler";
    private Context mContext;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        mContext = this;
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("acceptCall")) {
                                
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    @RequiresApi(api = VERSION_CODES.P)
    private void acceptCall() {
        TelecomManager tm = (TelecomManager) mContext.getSystemService(Context.TELECOM_SERVICE);

        if (tm != null) {
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ANSWER_PHONE_CALLS) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return;
            }
            boolean success = tm.endCall();
            // success == true if call was terminated.
        }
    }
}