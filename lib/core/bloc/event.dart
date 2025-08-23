import 'package:equatable/equatable.dart';

abstract class BlocEvent extends Equatable {
  const BlocEvent();
  @override
  List<Object> get props => [];
}

abstract class PaginationEvent extends BlocEvent {
  const PaginationEvent();
}

class OnLoadItems extends PaginationEvent {
  final int page;

  const OnLoadItems(this.page);
}

class OnItemsLoaded<T> extends PaginationEvent {
  final List<T> previews;
  final int page;

  @override
  List<Object> get props => [page, previews];

  const OnItemsLoaded(this.previews, this.page);
}
