part of 'auth_bloc.dart';

enum AuthStatus {
  init,
  loading,
  success,
  failure,
}

extension StatusExtension on AuthStatus {
  bool get isInit => this == AuthStatus.init;

  bool get isLoading => this == AuthStatus.loading;

  bool get isSuccess => this == AuthStatus.success;

  bool get isFailure => this == AuthStatus.failure;
}

class AuthState extends Equatable {
  final AuthStatus status;
  final bool isAuth;
  final UserEntity? user;
  final Failure? failure;

  const AuthState(
      {this.status = AuthStatus.init,
      this.isAuth = false,
      this.failure,
      this.user});

  AuthState copyWith({
    AuthStatus? status,
    bool? isAuth,
    UserEntity? user,
    Failure? failure,
  }) {
    return AuthState(
      status: status ?? this.status,
      isAuth: isAuth ?? this.isAuth,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, isAuth, user, failure];
}
