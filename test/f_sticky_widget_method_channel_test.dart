import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f_sticky_widget/f_sticky_widget_method_channel.dart';

void main() {
  MethodChannelFStickyWidget platform = MethodChannelFStickyWidget();
  const MethodChannel channel = MethodChannel('f_sticky_widget');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
