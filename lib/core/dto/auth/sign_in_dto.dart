import 'package:equatable/equatable.dart';

class SignInDto extends Equatable {
  final String email;
  final String password;

  const SignInDto({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory SignInDto.fromMap(Map<String, dynamic> map) {
    return SignInDto(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
