import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../error/failures.dart';
import '../error/mix.dart';
import '../utils/common.dart';

sealed class BlocMessage {
  final String text;

  BlocMessage(String text)
    : text = text.length > 100 ? '${text.substring(0, 100)}...' : text;
}

final class BlocSuccessMessage extends BlocMessage {
  BlocSuccessMessage(super.text);
}

final class BlocFailureMessage extends BlocMessage {
  BlocFailureMessage(super.text);
}

final class BlocWarningMessage extends BlocMessage {
  BlocWarningMessage(super.text);
}

final class BlocInfoMessage extends BlocMessage {
  BlocInfoMessage(super.text);
}

mixin BlocMessenger<S> on BlocBase<S> {
  final _messagesPip = StreamController<BlocMessage>();

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    if (error is Failure) {
      addFailure(error.message);
    } else {
      addFailure(error.toString());
    }
    if (kDebugMode) {
      log.d(error);
    }
    super.addError(error, stackTrace);
  }

  @override
  Future<void> close() {
    _messagesPip.close();
    return super.close();
  }

  Stream<BlocMessage> get messages => _messagesPip.stream;

  R? handleResult<T, R>(
    Mix<T> result, [
    R? Function(T result)? handler,
    void Function()? onFailure,
  ]) => result.fold(
    (l) {
      addError(l);
      onFailure?.call();
      return null;
    },
    (r) {
      return handler?.call(r);
    },
  );

  void addInfoDebug(String message) {
    if (kDebugMode) {
      addInfo(message);
      log.d(message);
    }
  }

  void addFailure(String? message) =>
      _addMessage(BlocFailureMessage(message ?? 'unKnown error'));

  void addSuccess(String? message) =>
      _addMessage(BlocSuccessMessage(message ?? 'unKnown error'));

  void addWarning(String? message) =>
      _addMessage(BlocWarningMessage(message ?? 'unKnown error'));

  void addInfo(String? message) =>
      _addMessage(BlocInfoMessage(message ?? 'unKnown error'));

  void _addMessage(BlocMessage message) {
    _messagesPip.add(message);
  }
}
