import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/errors/exceptions/exceptions.dart';
import 'package:weather_app/data/models/token_model.dart';
import 'package:weather_app/data/services/auth/auth_service_imp.dart';
import 'package:weather_app/data/services/auth/fake_auth.dart';
import 'package:weather_app/data/services/environment/environment_service.dart';
import 'package:weather_app/data/services/network/network_service.dart';
import 'package:weather_app/data/services/storage/storage_service.dart';

import '../../../../constants/data_mocks.dart';

class MockNetworkService extends Mock implements NetworkService {}

class MockStorageService extends Mock implements StorageService {}

class MockFakeAuth extends Mock implements FakeAuth {}

void main() {
  late MockNetworkService networkService;
  late AuthServiceImp authServiceImp;
  late MockStorageService storageService;
  late MockFakeAuth fakeAuth;

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ""));
    registerFallbackValue(const TokenModel(assessToken: "", tokenType: ""));
  });

  setUp(() async {
    await EnvironmentService.config();
    networkService = MockNetworkService();
    storageService = MockStorageService();
    fakeAuth = MockFakeAuth();

    authServiceImp = AuthServiceImp(
      networkService: networkService,
      fakeAuth: fakeAuth,
      storageService: storageService,
    );
  });

  group("SignIn", () {
    group("When Online", () {
      setUp(() {
        when(() => networkService.hasConnexion).thenAnswer((_) async => true);
      });

      test("Should return UserModel when response 201 ", () async {
        when(() => fakeAuth.signIn(
            email: any(named: "email"),
            password: any(named: "password"))).thenAnswer(
          (_) async => userMap,
        );
        when(() => storageService.cached(token: any(named: "token")))
            .thenAnswer(
          (_) async => true,
        );

        final result = await authServiceImp.signIn(signInDto: tSignInDto);

        expect(result, tUserModel);
      });

      test("Should throw StorageException when token not cached ", () async {
        when(
          () => fakeAuth.signIn(
            email: any(named: "email"),
            password: any(
              named: "password",
            ),
          ),
        ).thenAnswer(
          (_) async => userMap,
        );
        when(() => storageService.cached(token: any(named: "token")))
            .thenThrow(StorageException());

        final result = authServiceImp.signIn;

        expect(() => result(signInDto: tSignInDto),
            throwsA(const TypeMatcher<StorageException>()));
      });

      test("Should throw UnauthorizedException when user not found", () async {
        when(
          () => fakeAuth.signIn(
            email: any(named: "email"),
            password: any(named: "password"),
          ),
        ).thenThrow(const UnauthorizedException());
        final result = authServiceImp.signIn;

        expect(
          () => result(signInDto: tSignInDto),
          throwsA(
            const TypeMatcher<UnauthorizedException>(),
          ),
        );
      });
    });
    test("Should throw NetworkException when offline", () async {
      when(() => networkService.hasConnexion).thenAnswer((_) async => false);
      final result = authServiceImp.signIn;
      expect(
        () => result(
          signInDto: tSignInDto,
        ),
        throwsA(
          const TypeMatcher<NetworkException>(),
        ),
      );
    });
  });

  group("isAuthenticated", () {
    test("Should return true when token not null", () async {
      when(() => storageService.getToken()).thenAnswer(
        (_) async => tTokenModel,
      );
      final result = await authServiceImp.isAuthenticated();
      expect(result, true);
    });

    test("Should return false when token  null", () async {
      when(() => storageService.getToken()).thenAnswer(
        (_) async => null,
      );
      final result = await authServiceImp.isAuthenticated();
      expect(result, false);
    });

    test("Should return StorageException when read failure", () async {
      when(() => storageService.getToken()).thenThrow(StorageException());

      final result = authServiceImp.isAuthenticated;
      expect(() => result(), throwsA(const TypeMatcher<StorageException>()));
    });
  });

  group("LogOut", () {
    test("Should return true after removeToken", () async {
      when(() => storageService.removeToken()).thenAnswer((_) async => true);
      final result = await authServiceImp.logOut();
      verify(() => storageService.removeToken()).called(1);
      expect(result, true);
    });

    test("Should throw StorageException then failure removeToken", () async {
      when(() => storageService.removeToken()).thenThrow(StorageException());
      expect(() => authServiceImp.logOut(),
          throwsA(const TypeMatcher<StorageException>()));
    });
  });
}
