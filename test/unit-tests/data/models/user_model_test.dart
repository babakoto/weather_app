import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/user_model.dart';
import 'package:weather_app/domain/entities/user_entity.dart';

import '../../../constants/data_mocks.dart';

void main() {
  test("UserModel Should be subclass UserEntity", () {
    expect(tUserModel, isA<UserEntity>());
  });

  test("FromJson should return UserModel", () {
    expect(UserModel.fromJson(tUserMap), tUserModel);
  });

  test("toJson should return Map<String,dynamic>", () {
    expect(tUserModel.toJson(), tUserMap);
  });
}
