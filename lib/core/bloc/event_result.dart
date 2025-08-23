import 'dart:async';

import 'package:bloc/bloc.dart';

mixin ResultingEvent {
  final _result = Completer<bool>();
  void get success => _result.complete(true);
  void get fail => _result.complete(false);
}

mixin ResultingEventBloc<Event, S> on Bloc<Event, S> {
  Future<bool> addWithResult(ResultingEvent event) {
    super.add(event as Event);
    return event._result.future;
  }

  // @override
  // void on<E extends Event>(EventHandler<E, S> handler,
  //     {EventTransformer<E>? transformer}) {
  //   resultHandler(event, emit) {
  //     handler(event, emit);
  //     if (event is ResultingEvent) {
  //       event.result.complete();
  //     }
  //   }

  //   super.on(resultHandler, transformer: transformer);
  // }
}
