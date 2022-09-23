import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Fos<Failure, UserEntity>> signIn({required SignInDto signInDto});
  Future<Fos<Failure, UserEntity>> currentUser();
  Future<Fos<Failure, bool>> isAuthenticated();
  Future<Fos<Failure, bool>> logOut();
}
