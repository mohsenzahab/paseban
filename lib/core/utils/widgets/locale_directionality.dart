import 'package:flutter/material.dart';

import '../localizations.dart';

class LocaleDirectionality extends StatelessWidget {
  const LocaleDirectionality({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: getLocaleDirectionality(context), child: child);
  }
}
