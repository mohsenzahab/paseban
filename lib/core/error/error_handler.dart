// import 'package:graphql/client.dart';
// import 'package:dio/dio.dart' as dio;
// import 'exceptions.dart' as e;

// /// Handles a GraphQL request.
// ///
// /// This function takes a [future] that represents a future [QueryResult]
// /// obtained from a GraphQL query. It returns a [Future] that resolves to a
// /// [Map] containing the data from the response, or throws an exception if
// /// there was an error.
// ///
// /// The function first waits for the [future] to complete and then checks if
// /// there was an exception in the response. If there was an exception, it checks
// /// if there were any GraphQL errors. If there were no GraphQL errors, it throws
// /// a [NetworkException]. If there were GraphQL errors, it throws a
// /// [ServerException] with the list of GraphQL errors as the message.
// ///
// /// If there was no exception in the response, it returns the data from the
// /// response.
// Future<Map<String, dynamic>?> handleGqlRequest(
//   Future<QueryResult<Object?>> Function() future,
// ) async {
//   // Wait for the future to complete and get the response
//   final response = await future();

//   // If there was an exception in the response, handle it
//   if (response.hasException) {
//     final error = response.exception!;

//     // If there were no GraphQL errors, throw a NetworkException
//     if (error.graphqlErrors.isEmpty) {
//       throw e.NetworkException(message: error.toString());
//     }

//     // If there were GraphQL errors, throw a ServerException with the errors
//     throw e.ServerException(
//       message: error.graphqlErrors.map((e) => e.message).join(', '),
//     );
//   }

//   // Return the data from the response
//   return response.data;
// }

// /// Handles a GraphQL stream.
// ///
// /// This function takes a [stream] that represents a stream of [QueryResult]
// /// obtained from a GraphQL query. It returns a new stream that resolves to a
// /// [Map] containing the data from each response, or throws an exception if
// /// there was an error.
// ///
// /// Each response in the [stream] is checked for exceptions. If there was an
// /// exception, it checks if there were any GraphQL errors. If there were no
// /// GraphQL errors, it throws a [NetworkException]. If there were GraphQL
// /// errors, it throws a [ServerException] with the list of GraphQL errors
// /// as the message.
// ///
// /// If there were no exceptions in the response, it returns the data from the
// /// response.
// ///
// /// The returned stream is a new stream that transforms each response in the
// /// original stream.
// Stream<Map<String, dynamic>?> handleGqlStream(
//   Stream<QueryResult<Object?>> stream,
// ) => stream.map((response) {
//   // Check if there was an exception in the response
//   if (response.hasException) {
//     final error = response.exception!;

//     // If there were no GraphQL errors, throw a NetworkException
//     if (error.graphqlErrors.isEmpty) {
//       throw e.NetworkException(message: error.toString());
//     }

//     // If there were GraphQL errors, throw a ServerException with the errors
//     throw e.ServerException(
//       message: error.graphqlErrors.map((e) => e.message).join(', '),
//     );
//   }

//   // Return the data from the response
//   return response.data;
// });

// Future<dio.Response<T>> handleRestfulRequest<T>(
//   Future<dio.Response<T>> Function() future,
// ) async {
//   // Wait for the future to complete and get the response
//   final response = await future();

//   // If the response status code is not 200, handle the error
//   if (response.statusCode != 200) {
//     throw e.NetworkException(
//       message:
//           'Network error: ${response.statusCode} - ${response.statusMessage}',
//     );
//   }

//   // Return the data from the response
//   return response;
// }

// Stream<T> handleRestfulStream<T>(Stream<T> stream) {
//   return stream.map((event) {
//     return event;
//   });
// }
