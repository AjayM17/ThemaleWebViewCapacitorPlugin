package com.custom_webview;

import android.util.Log;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

@NativePlugin
public class CustomWebView extends Plugin {

    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

//        JSObject ret = new JSObject();
        Log.e("test","tesing");
        Log.e("test",value);
    }
}
