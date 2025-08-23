import 'package:flutter/material.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider(
      {super.key,
      this.length,
      this.margin,
      this.thickness = 1.5,
      this.color = Colors.grey});

  final double? length;
  final double? thickness;
  final EdgeInsetsGeometry? margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: thickness,
      width: length,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
    );
  }
}
