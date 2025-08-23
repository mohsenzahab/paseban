import 'dart:developer';
import 'package:bloc/bloc.dart';

class AppObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // log('---\n onCreate -- ${bloc.runtimeType}\n');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // log('######\nonEvent -- ${bloc.runtimeType}, $event}\n');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // log('~~~~~~\n onChange -- ${bloc.runtimeType}, $change\n');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('>>>>>\n onTransition -- ${bloc.runtimeType}, $transition\n');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('!!!!!!!\n onError -- ${bloc.runtimeType}, $error\n');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}');
  }
}
