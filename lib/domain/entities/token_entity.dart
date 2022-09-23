import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  final String assessToken;
  final String tokenType;

  const TokenEntity({
    required this.assessToken,
    required this.tokenType,
  });

  @override
  List<Object> get props => [assessToken, tokenType];
}
