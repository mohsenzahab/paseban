import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';
import '../state.dart';

class BlocPaginatedListView<B extends PaginationBloc<T, S>,
    S extends PaginationBlocState<T>, T> extends StatelessWidget {
  /// Gives the items one by one to the builder
  const BlocPaginatedListView(
      {super.key,
      this.padding,
      this.loadingWidget,
      this.reverse = false,
      this.scrollController,
      required this.itemBuilder})
      : showByChunk = false;

  /// Gives the items in groups of [PaginationBlocState.pageCount] to the builder.
  const BlocPaginatedListView.showByChunk(
      {super.key,
      this.padding,
      this.loadingWidget,
      this.reverse = false,
      this.scrollController,
      required this.itemBuilder})
      : showByChunk = true;
  final Widget? loadingWidget;
  final Widget Function(BuildContext context, PaginationBlocState<T> state,
      List<T> items, int index) itemBuilder;
  final EdgeInsets? padding;
  final bool showByChunk;
  final bool reverse;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    // todo: handle the case, when items ends.
    return ListView.builder(
        controller: scrollController,
        padding: padding,
        reverse: reverse,
        itemBuilder: (context, index) {
          final bloc = context.read<B>();
          final state = bloc.state;
          final lastLoadedPageNumber =
              showByChunk ? state.page : state.page * state.pageCount;
          if (index > lastLoadedPageNumber) {
            return null;
          }
// todo: make blocBuilder be parent of list view so every item don't need to have extra widget.
          return BlocBuilder<B, S>(buildWhen: (p, c) {
            if (showByChunk) return (c.page - 1) == index;
            return (c.page - 1) * c.pageCount == index;
          }, builder: (context, state) {
            final size = MediaQuery.sizeOf(context);
            final newRequestingPageNumber =
                showByChunk ? state.page : state.page * state.pageCount;
            if (index == newRequestingPageNumber) {
              // it is loading the initial data so no need to request
              if (state.pagingItems.isNotEmpty) {
                context.read<B>().requestNextItems();
              }
              return loadingWidget ??
                  SizedBox(
                      width: size.width,
                      height: size.height * 1 / 4,
                      child: const Center(child: CircularProgressIndicator()));
            }

            return itemBuilder(context, state, state.pagingItems, index);
          });
        });
  }
}
