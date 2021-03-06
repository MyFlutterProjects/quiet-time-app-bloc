import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocSupervisorDelegate extends BlocDelegate {
  @override 
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('bloc: ${ bloc.runtimeType}, event: $event');
  }

  @override 
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override 
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('bloc: ${bloc.runtimeType}, error: $error');
  }
}