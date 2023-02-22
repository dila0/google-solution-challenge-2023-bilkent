//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_voice_processor/FlutterVoiceProcessorPlugin.h>)
#import <flutter_voice_processor/FlutterVoiceProcessorPlugin.h>
#else
@import flutter_voice_processor;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<porcupine_flutter/PorcupinePlugin.h>)
#import <porcupine_flutter/PorcupinePlugin.h>
#else
@import porcupine_flutter;
#endif

#if __has_include(<url_launcher_ios/FLTURLLauncherPlugin.h>)
#import <url_launcher_ios/FLTURLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterVoiceProcessorPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterVoiceProcessorPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [PorcupinePlugin registerWithRegistrar:[registry registrarForPlugin:@"PorcupinePlugin"]];
  [FLTURLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTURLLauncherPlugin"]];
}

@end
