# flutter_bugly_plugin

flutter_bugly_plugin

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Dio实例

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
    FlutterBuglyPlugin.reportException(exceptionName: err.type.toString(), reason: err.toString(), userInfo: {
      "request": requestString,
      "response": responseString,
    });
```

## 捕获dart以及UI错误看Example
