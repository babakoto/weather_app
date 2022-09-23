part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class OnSubmitSignIn extends SignInEvent {
  final SignInDto signInDto;

  const OnSubmitSignIn({
    required this.signInDto,
  });

  @override
  List<Object> get props => [signInDto];
}
