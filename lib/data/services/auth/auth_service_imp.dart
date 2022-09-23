import 'dart:convert';

import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/core/errors/exceptions/exceptions.dart';
import 'package:weather_app/data/models/token_model.dart';
import 'package:weather_app/data/models/user_model.dart';
import 'package:weather_app/data/services/auth/auth_service.dart';
import 'package:weather_app/data/services/auth/fake_auth.dart';
import 'package:weather_app/data/services/logger/logger_service.dart';
import 'package:weather_app/data/services/network/network_service.dart';
import 'package:weather_app/data/services/storage/storage_service.dart';

class AuthServiceImp implements AuthService {
  final FakeAuth fakeAuth;
  final NetworkService _networkService;
  final StorageService _storageService;
  final LoggerService? loggerService;

  @override
  Future<UserModel> signIn({required SignInDto signInDto}) async {
    try {
      if (await _networkService.hasConnexion) {
        final response = await fakeAuth.signIn(
            email: signInDto.email, password: signInDto.password);

        final user = UserModel.fromJson(response);
        await _storageService.cached(
          token: TokenModel(
              assessToken: jsonEncode(user.toJson()), tokenType: "bearer"),
        );
        return user;
      } else {
        throw const NetworkException();
      }
    } on NetworkException {
      rethrow;
    } on StorageException {
      rethrow;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final result = await _storageService.getToken();
      if (result != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      final result = await _storageService.removeToken();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  const AuthServiceImp({
    required this.fakeAuth,
    this.loggerService,
    required NetworkService networkService,
    required StorageService storageService,
  })  : _networkService = networkService,
        _storageService = storageService;

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final result = await _storageService.getToken();
      final map = jsonDecode(result!.assessToken);
      return UserModel.fromJson(map);
    } catch (e) {
      throw StorageException();
    }
  }
}
