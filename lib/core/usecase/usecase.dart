import '../error/exception_handler.dart';
import '../error/mix.dart';
export '../error/mix.dart';
export '../error/exception_handler.dart';

/// abstract usecase class for handling async calls
abstract class UsecaseF<T, P> {
  const UsecaseF();
  Future<Mix<T>> call(P params);
}

/// abstract usecase class for handling async* calls.
abstract class UsecaseSM<T, P> {
  const UsecaseSM();
  Stream<Mix<T>> call(P params);
}

/// abstract usecase class for handling async* calls. error handling can be done
/// using the built in stream error handlers
abstract class UsecaseS<T, P> {
  const UsecaseS();
  Stream<T> call(P params);
}

/// abstract usecase class for real time calls.
abstract class Usecase<T, P> {
  const Usecase();
  Mix<T> call(P params) {
    return handleExceptions(() => callBody(params));
  }

  T callBody(P params);
}

/// Usecase call input parameter with no data.
class NoParams {
  const NoParams();
}
