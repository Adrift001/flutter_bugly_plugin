import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterBuglyPlugin {

  static const MethodChannel _channel =
      const MethodChannel('flutter_bugly_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 初始化
  static Future<void> init({@required String appIdAndroid, @required String appIdiOS}) async {

    assert(appIdAndroid != null);
    assert(appIdiOS != null);

    await _channel.invokeMethod("init", {
      "appIdAndroid": appIdAndroid,
      "appIdiOS": appIdiOS
    });
  }

  /// 设置设置用户标识
  static void setUserIdentifier({@required String userIdentifier}) {
    if (userIdentifier == null || userIdentifier.isEmpty) {
      return;
    }
    _channel
        .invokeMethod("setUserIdentifier", {"userIdentifier": userIdentifier});
  }

  /// 设置标签, 标签ID，可在网站生成
  static void setTag({@required int tag}) {
    if (tag < 0) {
      return;
    }
    _channel.invokeMethod("setTag", {"tag": tag});
  }

  /// 上报错误信息
  /// exceptionName 错误信息名称
  /// 错误原因
  /// 需要携带的其他数据
  static Future<void> reportException(
      {@required String exceptionName,
      String reason,
      Map<String, dynamic> userInfo}) async {
    if (exceptionName == null || exceptionName.isEmpty) {
      return;
    }
    await _channel.invokeMethod("reportException", {
      "exceptionName": exceptionName,
      "reason": reason,
      "userInfo": userInfo
    });
  }
}
