part of 'sign_in_bloc.dart';

enum SignInStatus {
  init,
  loading,
  success,
  failure,
}

extension StatusExtension on SignInStatus {
  bool get isInit => this == SignInStatus.init;

  bool get isLoading => this == SignInStatus.loading;

  bool get isSuccess => this == SignInStatus.success;

  bool get isFailure => this == SignInStatus.failure;
}

class SignInState extends Equatable {
  final Failure? failure;
  final UserEntity? user;
  final SignInStatus status;

  const SignInState({
    this.failure,
    this.user,
    this.status = SignInStatus.init,
  });

  @override
  List<Object?> get props => [failure, user, status];

  SignInState copyWith({
    Failure? failure,
    UserEntity? user,
    SignInStatus? status,
  }) {
    return SignInState(
      failure: failure ?? this.failure,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
