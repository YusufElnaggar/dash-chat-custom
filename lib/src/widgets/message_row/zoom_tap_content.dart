import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ZoomTapContent extends StatelessWidget {

  const ZoomTapContent({
    required this.child,
    this.onTap,
    this.hoverCursor = SystemMouseCursors.click,
    Key? key,
  }): super(key: key);

  final Widget child;
  final Function()? onTap;
  final MouseCursor hoverCursor;

  @override
  Widget build(BuildContext context) {
    if (onTap == null) {
      return child;
    }
    return MouseRegion(
      cursor: hoverCursor,
      child: ZoomTapAnimation(
        onTap: onTap,
        child: child
      ),
    );
  }
}
