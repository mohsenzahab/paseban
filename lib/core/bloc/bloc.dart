import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

mixin MessageCleaner<State extends BlocState> on BlocBase<State> {
  void clearMessage() =>
      emit(state.copyWith(state.status, message: null) as State);
}

// abstract class PaginationBloc<S extends PaginationBlocState>
//     extends Bloc<PaginationEvent, S> {
abstract class PaginationBloc<T, S extends PaginationBlocState<T>>
    extends Bloc<PaginationEvent, S> {
  PaginationBloc(super.initialState) {
    on<OnLoadItems>((event, emit) {
      emit(state.copyWith(
        BlocStatus.loading,
        page: state.page,
        pagingItems: state.pagingItems,
      ) as S);
      _getItems(event.page);
    });
    on<OnItemsLoaded>((event, emit) {
      emit(state.copyWith(BlocStatus.ready,
          page: event.page,
          pagingItems: [...state.pagingItems, ...event.previews]) as S);
    });
    onRegisterEventHandlers();
    _loadInitialData();
  }

  void onLoadInitialData();

  void onRegisterEventHandlers();

  void _loadInitialData() {
    add(const OnLoadItems(1));
    onLoadInitialData();
  }

  Future<void> _getItems(int page) async {
    final items = await getPageItems(page);
    add(OnItemsLoaded(items, page));
  }

  Future<List<T>> getPageItems(int page);
  void requestNextItems() {
    add(OnLoadItems(state.page + 1));
  }
}
