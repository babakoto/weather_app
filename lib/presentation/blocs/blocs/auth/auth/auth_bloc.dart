import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/domain/entities/user_entity.dart';
import 'package:weather_app/domain/usecases/auth/current_user_ucecase.dart';
import 'package:weather_app/domain/usecases/auth/is_authenticated_usecase.dart';
import 'package:weather_app/domain/usecases/auth/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsAuthenticatedUseCase isAuthenticatedUseCase;
  final LogOutUseCase logOutUseCase;
  final CurrentUserUseCase currentUserUseCase;

  AuthBloc(
      {required this.isAuthenticatedUseCase,
      required this.logOutUseCase,
      required this.currentUserUseCase})
      : super(const AuthState()) {
    on<IsAuthenticatedEvent>(_onAppStart);
    on<OnLogOutEvent>(_logoutEvent);
  }

  Future<void> _onAppStart(
      IsAuthenticatedEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final isAuthResult = await isAuthenticatedUseCase();
    final userResult = await currentUserUseCase();

    userResult.on((failure) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          failure: failure,
        ),
      );
    }, (success) {
      emit(
        state.copyWith(
          status: AuthStatus.success,
          failure: null,
          user: success,
        ),
      );
    });

    isAuthResult.on((failure) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          failure: failure,
        ),
      );
    }, (success) {
      emit(
        state.copyWith(
          status: AuthStatus.success,
          failure: null,
          isAuth: success,
        ),
      );
    });
  }

  FutureOr<void> _logoutEvent(
      OnLogOutEvent event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );
    final result = await logOutUseCase();
    result.on((failure) {
      emit(
        state.copyWith(
          failure: failure,
        ),
      );
    }, (success) {
      emit(
        state.copyWith(
          isAuth: false,
          failure: null,
          status: AuthStatus.success,
          user: null,
        ),
      );
    });
  }
}
