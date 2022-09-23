import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/data/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> signIn({required SignInDto signInDto});
  Future<UserModel> getCurrentUser();
  Future<bool> isAuthenticated();
  Future<bool> logOut();
}
