import 'package:flutter/material.dart';

import '../../localizations.dart';
import '../divider/custom_horizontal_divider.dart';
import '../route/animated_push.dart';

const kDefaultSnackbarDuration = Duration(seconds: 3);
const kStyleSnackBarMessenger = TextStyle();

/// UI for alert dialog comes in two types.
/// [AlertType.positive] meaning going with current action is safe.
/// [AlertType.negative] meaning that proceeding with current action may have consequences.
enum AlertType { positive, negative }

typedef DialogResultCallback = void Function(bool result);

// A tool for showing app messages to user.
class Messenger {
  Messenger(this.context);

  final BuildContext context;

  Future<bool?> showDialogAlert({
    required String title,
    String? description,
    required String positiveTextBtn,
    required String negativeTextBtn,
    bool twoSameBtn = false,
    void Function()? onSubmit,
    void Function()? onCancel,
    List<Widget> contents = const [],
    DialogResultCallback? dialogResultHandler,
    // AlertType alertType = AlertType.positive
  }) => pushWithAnimation<bool>(
    context,
    contentBuilder: (context) => _createAlertDialog(
      title: title,
      description: description,
      positiveTextBtn: positiveTextBtn,
      negativeTextBtn: negativeTextBtn,
      twoSameBtn: twoSameBtn,
      contents: contents,
      onCancel: onCancel,
      onSubmit: onSubmit,
    ),
    // dialogResultHandler
  );

  /// Show dedicated snackbar for success message
  void showSnackBarSuccess(String? message, {VoidCallback? onFinished}) =>
      _createSnackbar(
        message,
        label: 'confirm',
        onFinished: onFinished,
        defaultMessage: 'message',
      );

  /// Show dedicated snackbar for info message
  void showSnackBarInfo(
    String? message, {
    VoidCallback? onFinished,
    String? label,
  }) => _createSnackbar(
    message,
    label: label,
    onFinished: onFinished,
    defaultMessage: 'message',
  );

  /// Show dedicated snackbar for failure message
  void showSnackBarFailure(String? message, {VoidCallback? onFinished}) =>
      _createSnackbar(
        message,
        label: 'confirm',
        onFinished: onFinished,
        defaultMessage: 'message',
      );

  // void _showDialog(Dialog widget, [DialogResultCallback? resultHandler]) {
  //   showDialog<bool>(
  //     context: context,
  //     builder: (context) {
  //       return widget;
  //     },
  //   ).then((value) => resultHandler?.call(value ?? false));
  // }

  Dialog _createAlertDialog({
    required String title,
    String? description,
    required String positiveTextBtn,
    required String negativeTextBtn,
    required bool twoSameBtn,
    List<Widget> contents = const [],
    void Function()? onSubmit,
    void Function()? onCancel,
  }) {
    return Dialog(
      elevation: 0,
      // surfaceTintColor: Colors.transparent,
      // shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(title, textAlign: TextAlign.center),
            ),
            if (description != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Text(description, textAlign: TextAlign.end),
              ),
            ...contents,
            // alertType == AlertType.positive
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: CustomHorizontalDivider(
                color: Colors.grey,
                thickness: 0.5,
              ),
            ),
            //     ?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                    // onCancel?.call();
                  },
                  child: Text(negativeTextBtn),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    // onSubmit?.call();
                  },
                  child: Text(positiveTextBtn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ScaffoldMessengerState _createSnackbar(
    String? message, {
    String? label,
    Color? backgroundColor,
    Duration duration = kDefaultSnackbarDuration,
    String defaultMessage = 'message',
    SnackBarClosedReason reason = SnackBarClosedReason.hide,
    VoidCallback? postCallback,
    VoidCallback? onFinished,
  }) {
    return ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          action: label == null
              ? null
              : SnackBarAction(
                  label: label,
                  textColor: Colors.black,
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).hideCurrentSnackBar(reason: reason);
                  },
                ),
          behavior: SnackBarBehavior.floating,
          duration: duration,
          backgroundColor: backgroundColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
          width: message == null
              ? (defaultMessage.length.toDouble() * 8) + 20
              : label == null
              ? (message.length.toDouble() * 6.8) + 20
              : (message.length.toDouble() * 7) + 120,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message ?? defaultMessage,
                textDirection: getLocaleDirectionality(context),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ).closed.then((value) {
        switch (value) {
          case SnackBarClosedReason.action:
            postCallback?.call();
            break;
          case SnackBarClosedReason.dismiss:
          case SnackBarClosedReason.swipe:
          case SnackBarClosedReason.hide:
          case SnackBarClosedReason.remove:
          case SnackBarClosedReason.timeout:
            onFinished?.call();
        }
      });
  }
}

class SnackbarProgressIndicator extends StatefulWidget {
  const SnackbarProgressIndicator({
    super.key,
    this.duration = const Duration(milliseconds: 2000),
  });

  final Duration duration;

  @override
  State<SnackbarProgressIndicator> createState() =>
      _SnackbarProgressIndicatorState();
}

class _SnackbarProgressIndicatorState extends State<SnackbarProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    // controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: controller.value);
  }
}
