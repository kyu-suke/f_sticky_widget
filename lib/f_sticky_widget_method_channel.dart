import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'f_sticky_widget_platform_interface.dart';

/// An implementation of [FStickyWidgetPlatform] that uses method channels.
class MethodChannelFStickyWidget extends FStickyWidgetPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('f_sticky_widget');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
