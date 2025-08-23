import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_messenger.dart';
import 'bloc_messenger_prefs.dart';

typedef BlocMessageHandler =
    void Function(BuildContext context, BlocMessage message, Color color);

class BlocMessageListener<B extends BlocMessenger<Object>>
    extends StatefulWidget {
  final Widget child;
  final BlocMessageHandler? onMessage;
  final Duration? duration;
  final List<BlocMessenger>? blocs;

  const BlocMessageListener({
    required this.child,
    this.onMessage,
    this.duration,
    super.key,
  }) : blocs = null;

  const BlocMessageListener.group({
    required this.child,
    required this.blocs,
    this.onMessage,
    this.duration,
    super.key,
  });

  @override
  _BlocMessageListenerState<B> createState() => _BlocMessageListenerState<B>();
}

class _BlocMessageListenerState<B extends BlocMessenger<Object>>
    extends State<BlocMessageListener<B>> {
  final List<StreamSubscription<BlocMessage>> _subscriptions = [];

  BlocMessageHandler get _effectiveBlocMessageHandler =>
      widget.onMessage ??
      BlocMessengerPrefs.of(context)?.messageHandler ??
      _defaultMessageHandler;

  @override
  void initState() {
    super.initState();
    if (widget.blocs == null) {
      final bloc = BlocProvider.of<B>(context);

      _subscriptions.add(
        bloc.messages.listen((message) {
          _effectiveBlocMessageHandler(
            context,
            message,
            _getMessageColor(message),
          );
        }),
      );
    } else {
      for (final bloc in widget.blocs!) {
        _subscriptions.add(
          bloc.messages.listen((message) {
            _effectiveBlocMessageHandler(
              context,
              message,
              _getMessageColor(message),
            );
          }),
        );
      }
    }
  }

  void _defaultMessageHandler(
    BuildContext context,
    BlocMessage message, [
    Color? color,
  ]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.text),
        backgroundColor: color,
        duration: widget.duration ?? const Duration(seconds: 2),
      ),
    );
  }

  Color _getMessageColor(BlocMessage message) {
    if (message is BlocSuccessMessage) {
      return Colors.green;
    } else if (message is BlocFailureMessage) {
      return Colors.red;
    } else if (message is BlocWarningMessage) {
      return Colors.orange;
    } else {
      return Colors.blue;
    }
  }

  @override
  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
