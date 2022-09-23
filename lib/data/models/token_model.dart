import 'package:weather_app/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  const TokenModel({
    required super.assessToken,
    required super.tokenType,
  });

  Map<String, dynamic> toJon() {
    return {
      'access_token': assessToken,
      'token_type': tokenType,
    };
  }

  factory TokenModel.fromJson(Map<String, dynamic> map) {
    return TokenModel(
      assessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
    );
  }
}
