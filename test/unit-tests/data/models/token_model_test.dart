import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/token_model.dart';
import 'package:weather_app/domain/entities/token_entity.dart';

import '../../../constants/data_mocks.dart';

void main() {
  test('TokenModel should be subclass TokenEntity', () {
    expect(tTokenModel, isA<TokenEntity>());
  });

  test('fromJson should return TokenModel', () {
    final map = jsonDecode(tToken);
    expect(
      TokenModel.fromJson(map),
      TokenModel(
        assessToken: map["access_token"],
        tokenType: map["token_type"],
      ),
    );
  });

  test('toJson should return Map<String,dynamic>', () {
    final map = jsonDecode(tToken);
    final token = TokenModel(
      assessToken: map["access_token"],
      tokenType: map["token_type"],
    );
    expect(
      token.toJon(),
      {"access_token": map["access_token"], "token_type": map["token_type"]},
    );
  });
}
