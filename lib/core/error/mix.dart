import 'package:dartz/dartz.dart';

import 'failures.dart';

/// A type alias for [Either] that represents a value that can be either a [Failure] or a generic type [T].
///
/// This type is commonly used in the context of handling errors in a functional programming style,
/// where the presence of a [Failure] indicates that an error has occurred and the value is therefore
/// not usable.
///
/// The type alias is defined as `typedef Mix<T> = Either<Failure, T>;`.
/// The `Either` type is a generic class that can hold a value of type [T] on the right side (representing success),
/// or a value of type [Failure] on the left side (representing failure).
///
/// The [Mix] type is typically used in the context of functions that can fail, such as network requests or database
/// operations. It allows for more flexibility and control over error handling compared to using traditional exceptions.
///
/// For example, a function that fetches data from a network might return a [Mix] object, where the [Right] side
/// contains the fetched data, and the [Left] side contains a [Failure] object if the request failed.
typedef Mix<T> = Either<Failure, T>;
typedef MixR<T> = Right<Failure, T>;
typedef MixL<T> = Left<Failure, T>;
