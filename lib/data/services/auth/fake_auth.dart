import 'package:collection/collection.dart';
import 'package:weather_app/core/constants/fake_users.dart';
import 'package:weather_app/core/errors/exceptions/exceptions.dart';

class FakeAuth {
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    /// MOCK LOADING
    await Future.delayed(const Duration(seconds: 2));
    Map<String, dynamic>? user = users.firstWhereOrNull(
        (user) => user["email"] == email && user["password"] == password);
    if (user == null) {
      throw const UnauthorizedException();
    } else {
      return user;
    }
  }
}
