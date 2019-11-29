#import "FlutterPlayerPlugin.h"
#import <flutter_player_plugin/flutter_player_plugin-Swift.h>

@implementation FlutterPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPlayerPlugin registerWithRegistrar:registrar];
}
@end
