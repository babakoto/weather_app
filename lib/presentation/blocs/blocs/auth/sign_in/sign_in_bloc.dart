import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/domain/entities/user_entity.dart';
import 'package:weather_app/domain/usecases/auth/sign_in_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  SignInBloc({
    required this.signInUseCase,
  }) : super(const SignInState()) {
    on<OnSubmitSignIn>(_onSubmitSignIn);
  }

  Future<void> _onSubmitSignIn(
      OnSubmitSignIn event, Emitter<SignInState> emit) async {
    emit(state.copyWith(status: SignInStatus.loading));
    final response = await signInUseCase(input: event.signInDto);

    response.on(
      (failure) {
        emit(state.copyWith(failure: failure, status: SignInStatus.failure));
      },
      (success) {
        emit(
          state.copyWith(
            failure: null,
            status: SignInStatus.success,
            user: success,
          ),
        );
      },
    );
  }
}
