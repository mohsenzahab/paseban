import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/widgets/dialog/dialog.dart';
import 'bloc.dart';
import 'state.dart';

class BlocStatusListener {
  BlocStatusListener._();
  static bool listenWhen(
    BlocState previous,
    BlocState current, {
    bool Function(BlocState previous, BlocState current)? listenWhen,
  }) {
    return current.message != null &&
        (listenWhen?.call(previous, current) ?? true);
  }

  static void handle<T extends MessageCleaner>(
    BuildContext context,
    BlocState state,
  ) {
    if (state.message == null) return;
    ScaffoldMessenger.of(context).clearSnackBars();
    void onFinished() {
      context.read<T>().clearMessage();
    }

    switch (state.status) {
      case BlocStatus.loading:
        // TODO: Handle this case.
        break;
      // case BlocStatus.success:
      //   Messenger(context)
      //       .showSnackBarSuccess(state.message, onFinished: onFinished);

      //   break;
      case BlocStatus.ready:
        // Messenger(context).showSnackBarInfo(state.message);

        break;
      case BlocStatus.failure:
        Messenger(
          context,
        ).showSnackBarFailure(state.message, onFinished: onFinished);

        break;
      case BlocStatus.empty:
        // TODO: Handle this case.
        break;
    }
  }
}
