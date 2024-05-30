import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialState);
    on<HomeNavigatetoSignupPageEvent>(homeNavigatetoSignupPageState);
    on<HomeNavigatetoSigninPageEvent>(homeNavigatetoSigninPageState);
  }

  FutureOr<void> homeNavigatetoSignupPageState(
      HomeNavigatetoSignupPageEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigatetoSignupPageState());
  }

  FutureOr<void> homeNavigatetoSigninPageState(
      HomeNavigatetoSigninPageEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigatetoSigninPageState());
  }

  FutureOr<void> homeInitialState(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeInitial());
  }
}
