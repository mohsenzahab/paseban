import 'dart:async';
import '../utils/common.dart';
import 'exceptions.dart';
import 'failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'mix.dart';

/// Transforms a function that returns data into a [Mix] object, catching and
/// handling any exceptions that may occur.
///
/// The [action] parameter is the function that returns the data to be transformed.
///
/// The [onNoException] parameter is an optional callback that will be called
/// if no exceptions are thrown during the transformation.
///
/// Returns a [Mix] object that contains either the transformed data or a
/// [Failure] object if an exception occurred.
Mix<T> handleExceptions<T>(T Function() action, {VoidCallback? onNoException}) {
  try {
    // Call the action function and get the result.
    final result = action();

    // Call the onNoException callback if it is provided.
    onNoException?.call();

    // Wrap the result in a [Right] object and return it.
    return Right(result);
  } catch (e, stackTrace) {
    // Convert the exception to a [Failure] object.
    final failure = _errorToFailure(e);

    // Log the failure and stack trace.
    _logFailure(failure, stackTrace);

    // Wrap the failure in a [Left] object and return it.
    return Left(failure);
  }
}

/// Transforms a future of data into a future of [Mix] objects, catching and
/// handling any exceptions that may occur.
///
/// The [action] parameter is the future of data to be transformed.
///
/// The [onNoException] parameter is an optional callback that will be called
/// if no exceptions are thrown during the transformation.
///
/// Returns a transformed future of [Mix] objects.
Future<Mix<T>> handleExceptionsAsync<T>(Future<T> Function() action,
    {VoidCallback? onNoException}) async {
  try {
    final result = await action();
    onNoException?.call();
    // If the action is successful, wrap the result in a [Right] object.
    return Right<Failure, T>(result);
  } catch (e, stackTrace) {
    // If an exception is caught, convert it to a [Failure] object, log the
    // failure and stack trace, and wrap the failure in a [Left] object.
    final failure = _errorToFailure(e);
    _logFailure(failure, stackTrace);
    return Left(failure);
  }
}

// Future<Mix<T>> handleExceptionsAsync<T>(Future<T> Function() action,
//     {VoidCallback? onNoException}) async {
//   try {
//     final result = await action();
//     onNoException?.call();
//     return Right(result);
//   } on ServerException catch (e, stackTrace) {
//     _logError(e, stackTrace);
//     return Left(ServerFailure(errCode: e.errCode, message: e.message));
//   } on NetworkException catch (e, stackTrace) {
//     _logError(e, stackTrace);
//     return Left(NetworkFailure(errCode: e.errCode, message: e.message));
//   } on CacheException catch (e, stackTrace) {
//     _logError(e, stackTrace);
//     return Left(CacheFailure(errCode: e.errCode, message: e.message));
//   } on LocalException catch (e, stackTrace) {
//     _logError(e, stackTrace);
//     return Left(LocalFailure(errCode: e.errCode, message: e.message));
//   } catch (e) {
//     rethrow;
//   }
// }

/// Transforms a stream of data into a stream of [Mix] objects, catching and
/// handling any exceptions that may occur.
///
/// The [stream] parameter is the stream of data to be transformed.
///
/// The [onNoException] parameter is an optional callback that will be called
/// if no exceptions are thrown during the transformation.
///
/// Returns a transformed stream of [Mix] objects.
Stream<Mix<T>> handleExceptionsStream<T>(Stream<T> Function() stream,
    {VoidCallback? onNoException}) {
  // Transform the stream of data into a stream of [Mix] objects.
  return stream().transform<Mix<T>>(StreamTransformer<T, Mix<T>>.fromHandlers(
    // Handle the data by adding it to the sink wrapped in a [Right] object.
    handleData: (data, sink) => sink.add(Right(data)),
    // Handle errors by converting the error into a [Failure] object, logging
    // the failure and stack trace, and adding the failure to the sink wrapped
    // in a [Left] object.
    handleError: (error, stackTrace, sink) {
      final failure = _errorToFailure(error);
      _logFailure(failure, stackTrace);
      sink.add(Left(failure));
    },
  ));
}

/// Logs the [Failure] and the corresponding [StackTrace] to the [log]
///
/// This function is used to log the [Failure] and the [StackTrace]
/// whenever an error is encountered. The log message contains the
/// stack trace and the failure details.
///
/// Parameters:
///   - [f]: The [Failure] object to be logged.
///   - [st]: The [StackTrace] object associated with the failure.
void _logFailure(Failure f, StackTrace st) {
  // Log the failure and the stack trace.
  log.e('stack: $st\n${f.toString()}:${f.message}. errCode:${f.errCode}\n');
}

/// Transforms an error object into a failure object.
///
/// This function takes an error object and tries to identify its type. If the
/// error object is an instance of [CException], it uses a switch statement
/// to create the appropriate failure object based on the type of the exception.
/// If the error object is not an instance of [CException], it creates a
/// [LocalFailure] object with the error message as the message.
///
/// The returned failure object can then be used to propagate the error
/// information up the widget tree.
///
/// Parameters:
///   e: The error object to be transformed into a failure object.
///
/// Returns:
///   A [Failure] object representing the error.
Failure _errorToFailure(Object e) {
  if (e is CException) {
    // If the error object is an instance of CException, use a switch statement
    // to create the appropriate failure object based on the type of the exception.
    return switch (e) {
      // If the error object is an instance of ServerException, create a
      // ServerFailure object with the error code and message.
      ServerException() =>
        ServerFailure(errCode: e.errCode, message: e.message),
      // If the error object is an instance of NetworkException, create a
      // NetworkFailure object with the error code and message.
      NetworkException() =>
        NetworkFailure(errCode: e.errCode, message: e.message),
      // If the error object is an instance of CacheException, create a
      // CacheFailure object with the error code and message.
      CacheException() => CacheFailure(errCode: e.errCode, message: e.message),
      // If the error object is an instance of LocalException, create a
      // LocalFailure object with the error code and message.
      LocalException() => LocalFailure(errCode: e.errCode, message: e.message),
    };
  }
  // If the error object is not an instance of CException, create a
  // LocalFailure object with the error message.
  return LocalFailure(message: e.toString());
}
