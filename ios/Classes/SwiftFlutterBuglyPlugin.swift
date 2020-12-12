import Flutter
import UIKit
import Bugly

public class SwiftFlutterBuglyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_bugly_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterBuglyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let dic = call.arguments as? [String: Any] else {
        return
    }
    switch call.method {
    case "init":
        let appId = dic["appIdiOS"] as? String ?? ""
        Bugly.start(withAppId: appId)
    case "setUserIdentifier":
        let userIdentifier = dic["userIdentifier"] as? String ?? ""
        Bugly.setUserIdentifier(userIdentifier)
    case "setTag":
        let tag = dic["tag"] as? NSNumber ?? NSNumber(value: 0)
        Bugly.setTag(tag.uintValue)
    case "reportException":
        let exceptionName = dic["exceptionName"] as? String ?? ""
        let reason = dic["reason"] as? String ?? ""
        let userInfo = dic["userInfo"] as? [AnyHashable : Any] ?? [:]
        Bugly.report(NSException(name: NSExceptionName(rawValue: exceptionName), reason: reason, userInfo: userInfo))
    default:
        result("iOS " + UIDevice.current.systemVersion)
    }
  }
}
