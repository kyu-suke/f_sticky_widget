import 'package:flutter_test/flutter_test.dart';
import 'package:f_sticky_widget/f_sticky_widget.dart';
import 'package:f_sticky_widget/f_sticky_widget_platform_interface.dart';
import 'package:f_sticky_widget/f_sticky_widget_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFStickyWidgetPlatform
    with MockPlatformInterfaceMixin
    implements FStickyWidgetPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FStickyWidgetPlatform initialPlatform = FStickyWidgetPlatform.instance;

  test('$MethodChannelFStickyWidget is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFStickyWidget>());
  });

  test('getPlatformVersion', () async {
    FStickyWidget fStickyWidgetPlugin = FStickyWidget();
    MockFStickyWidgetPlatform fakePlatform = MockFStickyWidgetPlatform();
    FStickyWidgetPlatform.instance = fakePlatform;

    expect(await fStickyWidgetPlugin.getPlatformVersion(), '42');
  });
}
