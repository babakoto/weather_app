import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/errors/exceptions/exceptions.dart';
import 'package:weather_app/core/errors/failures/all_failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/data/repositories/auth_repository_imp.dart';
import 'package:weather_app/data/services/auth/auth_service.dart';

import '../../../constants/data_mocks.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService authService;
  late AuthRepositoryImp authRepositoryImp;

  setUp(() {
    authService = MockAuthService();
    authRepositoryImp = AuthRepositoryImp(
      authService: authService,
    );
  });

  group("SignIn", () {
    test('Should return SuccessResponse(UserEntity) when request success',
        () async {
      when(() => authService.signIn(signInDto: tSignInDto)).thenAnswer(
        (_) async => tUserModel,
      );

      final result = await authRepositoryImp.signIn(signInDto: tSignInDto);

      expect(result, const SuccessResponse(tUserModel));
    });

    const UnauthorizedException unauthorizedException = UnauthorizedException();
    const networkException = NetworkException();
    const ServerException serverException = ServerException();
    const unknownSignInException =
        UnknownException(message: "unknownException SignIn");
    test(
        'Should return FailureResponse(UnauthorizedFailure) when throw UnauthorizedException ',
        () async {
      when(() => authService.signIn(signInDto: tSignInDto))
          .thenThrow(unauthorizedException);

      final result = await authRepositoryImp.signIn(signInDto: tSignInDto);

      expect(
        result,
        FailureResponse(
          UnauthorizedFailure(
            message: unauthorizedException.message,
            code: unauthorizedException.code,
          ),
        ),
      );
    });

    test(
        'Should return FailureResponse(NetworkFailure) when throw NetworkException ',
        () async {
      when(() => authService.signIn(signInDto: tSignInDto))
          .thenThrow(networkException);

      final result = await authRepositoryImp.signIn(signInDto: tSignInDto);

      expect(
        result,
        FailureResponse(
          NetworkFailure(
            message: networkException.message,
            code: networkException.code,
          ),
        ),
      );
    });

    test(
        'Should return FailureResponse(UnknownException) when throw UnknownException ',
        () async {
      when(() => authService.signIn(signInDto: tSignInDto)).thenThrow(
        unknownSignInException,
      );

      final result = await authRepositoryImp.signIn(signInDto: tSignInDto);

      expect(
        result,
        FailureResponse(
          UnknownFailure(
            message: unknownSignInException.message,
          ),
        ),
      );
    });
  });

  group("isAuthenticated", () {
    setUp(() {});
    test("Should return SuccessResponse(true) when user authenticated",
        () async {
      when(() => authService.isAuthenticated()).thenAnswer((_) async => true);
      final result = await authRepositoryImp.isAuthenticated();
      expect(result, const SuccessResponse(true));
    });

    test(
        "Should return failureResponse(UnauthorizedFailure) when user not authenticated",
        () async {
      when(() => authService.isAuthenticated()).thenAnswer((_) async => false);
      final result = await authRepositoryImp.isAuthenticated();
      expect(result, const FailureResponse(UnauthorizedFailure()));
    });

    test(
        "Should return failureResponse(StorageFailure) when throw StorageException",
        () async {
      when(() => authService.isAuthenticated()).thenThrow(StorageException());
      final result = await authRepositoryImp.isAuthenticated();
      expect(result, FailureResponse(StorageFailure()));
    });
  });

  group("logOut", () {
    test("should return  SuccessResponse(true) when Success ", () async {
      when(() => authService.logOut()).thenAnswer((_) async => true);
      final result = await authRepositoryImp.logOut();
      expect(result, const SuccessResponse(true));
    });

    test("should return  FailureResponse(StorageFailure) from fail ", () async {
      when(() => authService.logOut()).thenThrow(StorageException());
      final result = await authRepositoryImp.logOut();
      expect(result, FailureResponse(StorageFailure()));
    });
  });
}
