import 'package:flutter/material.dart';

import 'bloc_message_listener.dart';

class BlocMessengerPrefs extends InheritedWidget {
  const BlocMessengerPrefs(
      {super.key, required super.child, required this.prefs});

  final BlocMessengerPrefsData prefs;

  static BlocMessengerPrefsData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BlocMessengerPrefs>()
        ?.prefs;
  }

  @override
  bool updateShouldNotify(BlocMessengerPrefs oldWidget) {
    return true;
  }
}

class BlocMessengerPrefsData {
  final BlocMessageHandler? messageHandler;

  BlocMessengerPrefsData({required this.messageHandler});
}
