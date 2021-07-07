# flutter_bugly_plugin

flutter_bugly_plugin

## 权限
### Android
```
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.READ_LOGS" />
```
### iOS不需要

## 安装

```
flutter_bugly_plugin: ^0.0.7
```

## 初始化看Example, 找合适的位置做初始化

## 上传错误

### 上传网络错误

```
    final request = err.request;
    final response = err.response;
    final requestString = json.encode({
      "url": request.path,
      "header": json.encode(request.headers),
      "query": json.encode(request.queryParameters),
      "data": json.encode(request.data),
    });
    final responseString = json.encode({
      "statusCode": response.statusCode,
      "data": json.encode(response.data)
    });
    // userInfo必须是{String, String}, Android限制
    FlutterBuglyPlugin.reportException(exceptionName: err.type.toString(), reason: err.toString(), userInfo: {
      "request": requestString,
      "response": responseString,
    });
```

### 上传dart以及UI错误看Example
