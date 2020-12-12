import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bugly_plugin/flutter_bugly_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBuglyPlugin.init(appIdAndroid: "d7ee5aca68", appIdiOS: "171b26a5e3");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    FlutterBuglyPlugin.setUserIdentifier(userIdentifier: "17600695209");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterBuglyPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              FlutterBuglyPlugin.reportException(exceptionName: "网络错误", reason: "原因原因原因原因原因原因原因原因", userInfo: {
                "abc": "abc",
                "def": 123,
                "ghi": true
              });
            },
            child: Container(
              child: Text('Running on: $_platformVersion\n'),
              width: 200,
              height: 200,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
