import 'package:flutter/widgets.dart';

class RefreshScrollPhysics extends ClampingScrollPhysics {
  const RefreshScrollPhysics({ScrollPhysics? parent});

  static bool forceToOverScroll = true;
  
  @override
  ClampingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return RefreshScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      // Underscroll.
      return value;
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
      // Overscroll.
      return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
      // Hit top edge.
      return value;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      // Hit bottom edge.
      return value - position.maxScrollExtent;
    }

    return forceToOverScroll ? 0 : value;
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return true;
  }
}