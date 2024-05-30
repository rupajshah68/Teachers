import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_bar_navigation_event.dart';
part 'bottom_bar_navigation_state.dart';

class BottomBarNavigationBloc
    extends Bloc<BottomBarNavigationEvent, BottomBarNavigationState> {
  BottomBarNavigationBloc() : super(BottomBarNavigationInitial()) {
    on<BottomBarNavigationNavigateEvent>(bottomBarNavigate);
  }

  FutureOr<void> bottomBarNavigate(BottomBarNavigationNavigateEvent event,
      Emitter<BottomBarNavigationState> emit) {
    emit(BottomBarNavigateState(selIndex: event.newIndex));
  }
}
