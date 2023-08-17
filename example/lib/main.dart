import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bugly_plugin/flutter_bugly_plugin.dart';

void main() {
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FlutterBuglyPlugin.reportException(
        exceptionName: error.toString(), reason: stackTrace.toString());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
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
  }

  Future<void> initBugly() async {
    FlutterBuglyPlugin.init(
        appIdAndroid: "d7ee5aca68", appIdiOS: "171b26a5e3",);
    final onError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      onError?.call(details);
      if (kReleaseMode) {
        FlutterBuglyPlugin.reportException(exceptionName: details.library ?? '', reason: details.exceptionAsString());
      }
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      if (kReleaseMode) {
        FlutterBuglyPlugin.reportException(exceptionName: error.toString(), reason: stack.toString());
      }
      return true;
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterBuglyPlugin example app'),
        ),
        body: FutureBuilder(
          future: initBugly(),
          builder: (context, snapshot) {
            return Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new TextButton(
                    child: new Text('Dart exception'),
                    onPressed: () {
                      throw new StateError('This is a Dart exception.');
                    },
                  ),
                  new TextButton(
                    child: new Text('async Dart exception'),
                    onPressed: () async {
                      foo() async {
                        throw new StateError(
                            'This is an async Dart exception.');
                      }

                      bar() async {
                        await foo();
                      }

                      await bar();
                    },
                  ),
                  new TextButton(
                    child: new Text('Java exception'),
                    onPressed: () async {
                      final channel =
                          const MethodChannel('crashy-custom-channel');
                      await channel.invokeMethod('blah');
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
