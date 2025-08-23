// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import '../../const/datacolors.dart';

class DividerOther extends StatelessWidget {
  const DividerOther({
    super.key,
    required this.text,
    // ignore: non_constant_identifier_names
    required this.textstyle,
  });

  final String text;
  // ignore: non_constant_identifier_names
  final TextStyle textstyle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Row(
      children: [
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(top: 3),
              width: size.width / 4,
              child: const Divider(
                // color: SolidColors.grey,
                color: Colors.grey,
                height: 0.2,
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(child: Text(text, style: textstyle)),
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.only(top: 3),
              width: size.width / 4,
              child: const Divider(
                // color: SolidColors.grey,
                color: Colors.grey,
                height: 0.2,
              )),
        ),
      ],
    );
  }
}
