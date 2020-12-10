#import "FlutterBuglyPlugin.h"
#if __has_include(<flutter_bugly_plugin/flutter_bugly_plugin-Swift.h>)
#import <flutter_bugly_plugin/flutter_bugly_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_bugly_plugin-Swift.h"
#endif

@implementation FlutterBuglyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterBuglyPlugin registerWithRegistrar:registrar];
}
@end
