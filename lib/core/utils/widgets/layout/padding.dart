import 'package:flutter/material.dart';

class StartPadding extends StatelessWidget {
  const StartPadding({super.key, this.padding = 8.0, this.child});
  final double padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsetsDirectional.only(start: padding),
        child: child,
      );
}

class EndPadding extends StatelessWidget {
  const EndPadding({super.key, this.padding = 8.0, this.child});
  final double padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsetsDirectional.only(end: padding),
        child: child,
      );
}
