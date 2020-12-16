package com.swifter.flutter_bugly_plugin

import android.content.Context
import androidx.annotation.NonNull
import com.tencent.bugly.crashreport.CrashReport

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutterBuglyPlugin */
class FlutterBuglyPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_bugly_plugin")
    channel.setMethodCallHandler(this)
    this.context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val dic = call.arguments as? Map<String, Any> ?: return
    when(call.method) {
      "init" -> {
        val appId = dic["appIdAndroid"] as? String ?: ""
        CrashReport.initCrashReport(context, appId, true)
      }
      "setUserIdentifier" -> {
        val userIdentifier = dic["userIdentifier"] as? String ?: ""
        CrashReport.setUserId(context, userIdentifier)
      }
      "setTag" -> {
        val tag = dic["tag"] as? Int ?: 0
        CrashReport.setUserSceneTag(context, tag)
      }
      "reportException" -> {
        val exceptionName = dic["exceptionName"] as? String ?: ""
        val reason = dic["reason"] as? String ?: ""
        val userInfo = dic["userInfo"] as? Map<String, String> ?: mapOf()
        CrashReport.postException(8, exceptionName, reason, "", userInfo)
      }
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
