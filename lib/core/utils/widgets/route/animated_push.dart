import 'dart:ui';

import 'package:flutter/material.dart';

typedef ContentBuilder = Widget Function(BuildContext context);

Future<T?> pushWithAnimation<T>(
  BuildContext context, {
  required ContentBuilder contentBuilder,
  bool scale = true,
  bool opacity = true,
  bool blur = true,
  bool barrierDismissible = true,
  double blurValue = 8,
  bool rootNavigator = true,
}) {
  return Navigator.of(context, rootNavigator: rootNavigator)
      .push<T>(PageRouteBuilder(
    opaque: false,
    fullscreenDialog: true,
    barrierDismissible: barrierDismissible,
    pageBuilder: (BuildContext outerContext, animation, ani) {
      return Theme(
          data: Theme.of(context), child: contentBuilder(outerContext));
    },
    transitionsBuilder: (context, animation, secondaryAnimation, c) {
      Widget child = c;
      if (opacity) {
        child = Opacity(opacity: animation.value, child: child);
      }
      if (scale) {
        child = Transform.scale(scale: animation.value, child: child);
      }
      if (blur) {
        child = BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: animation.value * blurValue,
              sigmaY: animation.value * blurValue),
          child: child,
        );
      }
      return child;
    },
  ));
}
