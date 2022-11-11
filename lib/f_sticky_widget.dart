import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FStickyWidget extends StatefulWidget {
  const FStickyWidget({
    super.key,
    required this.child,
    required this.color,
    required this.controller,
    this.track = false,
    this.widgetLocation = WidgetLocation.leftTop,
    this.widgetOffset = const WidgetOffset(),
  });

  final Widget child;
  final Color color;
  final bool track;
  final StickyController controller;
  final WidgetLocation widgetLocation;
  final WidgetOffset widgetOffset;

  @override
  State<FStickyWidget> createState() => _FStickyWidgetState();
}

class _FStickyWidgetState extends State<FStickyWidget> {
  GlobalKey gkey = GlobalKey();

  void move() {
    setState(() {
      height = _widgetKey.currentContext!.size!.height.toDouble();
      screenHeight = MediaQuery.of(context).size.height;
      RenderBox box =
      _widgetKey.currentContext!.findRenderObject() as RenderBox;
      widgetOffset = box.localToGlobal(Offset.zero);

      width = _widgetKey.currentContext!.size!.width.toDouble();
      screenWidth = MediaQuery.of(context).size.width;

      childWidth = gkey.currentContext?.size?.width.toDouble() ?? 0;
      childHeight = gkey.currentContext?.size?.height.toDouble() ?? 0;

      if (widget.track) {
        // print(leftPosition);
      }
    });
  }

  void rebuild() {
    move();
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      move();
      widget.controller.addListener(rebuild);
    });
  }

  double get topPosition {
    final bottom = widgetOffset.dy + widget.widgetOffset.top * -1;

    if ((bottom * -1) + childHeight > height) {
      return height - childHeight;
    } else if (bottom < 0) {
      return bottom * -1;
    } else {
      return 0;
    }
  }

  double get middlePosition {
    final bottom = widgetOffset.dy + widget.widgetOffset.top * -1;

    if (height < (-1*bottom)+childHeight) {
      return height - childHeight;
    } else if ((-1*bottom) > (height / 2) - (childHeight / 2)) {
      return -1*bottom;
    } else if (screenHeight > bottom && screenHeight - bottom < childHeight) {
      return 0;
    } else if (screenHeight - (height / 2) - (childHeight / 2) - bottom < 0) {
      return height - bottom + (screenHeight - height - childHeight);
    } else {
      return (height / 2) - (childHeight / 2);
    }
  }

  double get bottomPosition {
    final bottom = widgetOffset.dy;
    final widgetBottomEdge = bottom + height;

    if (widgetBottomEdge > screenHeight) {
      if (height - (screenHeight - bottom) > height - childHeight) {
        return height - childHeight;
      } else {
        return height - (screenHeight - bottom);
      }
    } else {
      return 0;
    }
  }

  double get leftPosition {
    final left = widgetOffset.dx * -1;
    final widgetLeftEdge = left + width;

    if (widgetLeftEdge - width + childWidth >= width) {
      print(width - childWidth);
      return width - childWidth;
    } else if (widgetLeftEdge > width) {
      return widgetLeftEdge - width;
    } else {
      return 0;
    }
  }
  double get centerPosition {
    final left = widgetOffset.dx;

    if (width < (-1*left)+childWidth) {
      return width - childWidth;
    } else if ((-1*left) > (width / 2) - (childWidth / 2)) {
      return -1*left;
    } else if (screenWidth > left && screenWidth - left < childWidth) {
      return 0;
    } else if (screenWidth - (width / 2) - (childWidth / 2) - left < 0) {
      return width - left + (screenWidth - width - childWidth);
    } else {
      return (width / 2) - (childWidth / 2);
    }
  }

  double get rightPosition {
    final left = widgetOffset.dx;

    if (width - screenWidth + left + childWidth > width) {
      return width - childWidth;
    } else if (width - screenWidth + left > 0) {
      return width - screenWidth + left;
    } else {
      return 0;
    }
  }

  final GlobalKey _widgetKey = GlobalKey();
  double screenHeight = 0;
  double height = 0;
  Offset widgetOffset = Offset.zero;
  double screenWidth = 0;
  double width = 0;
  double childWidth = 0;
  double childHeight = 0;

  get calsPos {
    if (widget.widgetLocation == WidgetLocation.leftTop) {
      return {
        "left": leftPosition,
        "top": topPosition,
        "right": null,
        "bottom": null
      };
    } else if (widget.widgetLocation == WidgetLocation.leftMiddle   ) {
      return {
        "left": leftPosition,
        "top": middlePosition,
        "right": null,
        "bottom": null
      };
    } else if (widget.widgetLocation == WidgetLocation.leftBottom   ) {
      return {
        "left": leftPosition,
        "top": null,
        "right": null,
        "bottom": bottomPosition
      };
    } else if (widget.widgetLocation == WidgetLocation.centerTop    ) {
      return {
        "left": centerPosition,
        "top": topPosition,
        "right": null,
        "bottom": null
      };
    } else if (widget.widgetLocation == WidgetLocation.centerMiddle ) {
      return {
        "left": centerPosition,
        "top": middlePosition,
        "right": null,
        "bottom": null
      };
    } else if (widget.widgetLocation == WidgetLocation.centerBottom ) {
      return {
        "left": centerPosition,
        "top": null,
        "right": null,
        "bottom": bottomPosition
      };
    } else if (widget.widgetLocation == WidgetLocation.rightTop     ) {
      return {
        "left": null,
        "top": topPosition,
        "right": rightPosition,
        "bottom": null
      };
    } else if (widget.widgetLocation == WidgetLocation.rightMiddle  ) {
      return {
        "left": null,
        "top": middlePosition,
        "right": rightPosition,
        "bottom": null
      };
    } else if (widget.widgetLocation == WidgetLocation.rightBottom  ) {
      return {
        "left": null,
        "top": null,
        "right": rightPosition,
        "bottom": bottomPosition
      };
    } else {
      return {
        "left": leftPosition,
        "top": null,
        "right": null,
        "bottom": bottomPosition
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _widgetKey,
      children: [
        Positioned(
          left: calsPos["left"],
          top: calsPos["top"],
          right: calsPos["right"],
          bottom: calsPos["bottom"],
          // child: widget.child,
          child: StickyChild(
            gkey: gkey,
            child: widget.child,
          ),
        )
      ],
    );
  }
}

class StickyChild extends StatelessWidget {
  StickyChild({required this.gkey, required this.child});

  late final GlobalKey gkey;
  late final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(key: gkey, child: child);
  }
}

class StickyController extends ChangeNotifier {
  StickyController();

  @override
  void dispose() {
    super.dispose();
  }

  void notify() {
    notifyListeners();
  }
}

enum WidgetLocation {
  leftTop,
  leftMiddle,
  leftBottom,
  centerTop,
  centerMiddle,
  centerBottom,
  rightTop,
  rightMiddle,
  rightBottom,
}

class WidgetOffset {
  const WidgetOffset({
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
  });

  final double left;
  final double top ;
  final double right;
  final double bottom;
}
