import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'f_sticky_widget_method_channel.dart';

abstract class FStickyWidgetPlatform extends PlatformInterface {
  /// Constructs a FStickyWidgetPlatform.
  FStickyWidgetPlatform() : super(token: _token);

  static final Object _token = Object();

  static FStickyWidgetPlatform _instance = MethodChannelFStickyWidget();

  /// The default instance of [FStickyWidgetPlatform] to use.
  ///
  /// Defaults to [MethodChannelFStickyWidget].
  static FStickyWidgetPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FStickyWidgetPlatform] when
  /// they register themselves.
  static set instance(FStickyWidgetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
