import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/core/errors/exceptions/exceptions.dart';
import 'package:weather_app/core/errors/failures/all_failure.dart';
import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/data/services/auth/auth_service.dart';
import 'package:weather_app/domain/entities/user_entity.dart';
import 'package:weather_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthService authService;

  @override
  Future<Fos<Failure, UserEntity>> signIn(
      {required SignInDto signInDto}) async {
    try {
      final userModel = await authService.signIn(signInDto: signInDto);
      return SuccessResponse(userModel);
    } on UnauthorizedException catch (e) {
      return FailureResponse(
        UnauthorizedFailure(code: e.code, message: e.message),
      );
    } on NetworkException catch (e) {
      return FailureResponse(
        NetworkFailure(code: e.code, message: e.message),
      );
    } on ServerException catch (e) {
      return FailureResponse(
        ServerFailure(code: e.code, message: e.message),
      );
    } catch (e) {
      return const FailureResponse(
        UnknownFailure(
          message: "unknownException SignIn",
        ),
      );
    }
  }

  const AuthRepositoryImp({
    required this.authService,
  });

  @override
  Future<Fos<Failure, bool>> isAuthenticated() async {
    try {
      final result = await authService.isAuthenticated();
      if (result) {
        return SuccessResponse(result);
      } else {
        return const FailureResponse(
          UnauthorizedFailure(),
        );
      }
    } catch (e) {
      return FailureResponse(StorageFailure());
    }
  }

  @override
  Future<Fos<Failure, bool>> logOut() async {
    try {
      final result = await authService.logOut();
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(StorageFailure());
    }
  }

  @override
  Future<Fos<Failure, UserEntity>> currentUser() async {
    try {
      final result = await authService.getCurrentUser();
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(StorageFailure());
    }
  }
}
