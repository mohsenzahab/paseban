// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum BlocStatus {
  loading,
  // success,
  ready,
  failure,
  empty;

  bool get isLoading => this == BlocStatus.loading;

  // bool get isSuccess => this == BlocStatus.success;
  bool get isReady => this == BlocStatus.ready;

  bool get isFailure => this == BlocStatus.failure;

  bool get isEmpty => this == BlocStatus.empty;
}

abstract class BlocState extends Equatable {
  const BlocState(this.status, {this.message});
  final BlocStatus status;
  final String? message;

  /// returns a new [BlocState] with this states data but
  /// replaced with provided values
  BlocState copyWith(BlocStatus status, {String? message});
  // {
  //   return BlocState(status, message: message);
  // }

  BlocState setLoading();

  @override
  List<Object?> get props;
}

class PaginationBlocState<T> extends BlocState {
  final int page;
  final List<T> pagingItems;
  int get pageCount => 10;
  const PaginationBlocState(
    super.status, {
    this.page = 0,
    required this.pagingItems,
    super.message,
  });

  List<T> getItemsChunk(int page) =>
      pagingItems.sublist(page * pageCount, (page + 1) * pageCount);

  /// returns a new [BlocState] with this states data but
  /// replaced with provided values.
  /// Must be overridden with return value of current subclass.
  @override
  PaginationBlocState<T> copyWith(
    BlocStatus status, {
    String? message,
    int? page,
    List<T>? pagingItems,
  }) {
    return PaginationBlocState(
      status,
      message: message,
      page: page ?? this.page,
      pagingItems: pagingItems ?? this.pagingItems,
    );
  }

  @override
  List<Object?> get props => [status, message, page, pageCount, pagingItems];

  @override
  BlocState setLoading() {
    return copyWith(BlocStatus.loading);
  }
}
