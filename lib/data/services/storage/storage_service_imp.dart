import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app/core/errors/exceptions/exceptions.dart';
import 'package:weather_app/data/models/token_model.dart';
import 'package:weather_app/data/services/logger/logger_service.dart';
import 'package:weather_app/data/services/storage/storage_path.dart';
import 'package:weather_app/data/services/storage/storage_service.dart';

class StorageServiceImp implements StorageService {
  final FlutterSecureStorage storage;
  final LoggerService? loggerService;

  @override
  Future<bool> cached({TokenModel? token}) async {
    loggerService?.debug(token);
    try {
      final data = jsonEncode(token?.toJon());
      await storage.write(
        key: StoragePath.token,
        value: data,
      );
      return Future.value(true);
    } catch (e) {
      throw StorageException();
    }
  }

  @override
  Future<TokenModel?> getToken() async {
    try {
      final data = await storage.read(key: StoragePath.token);
      if (data != null) {
        final map = jsonDecode(data);
        return TokenModel.fromJson(map);
      }
      return null;
    } catch (e) {
      throw StorageException();
    }
  }

  const StorageServiceImp({required this.storage, this.loggerService});

  @override
  Future<bool> removeToken() async {
    try {
      await storage.delete(key: StoragePath.token);
      final data = await storage.read(key: StoragePath.token);
      loggerService?.debug(data);
      return true;
    } catch (e) {
      throw StorageException();
    }
  }
}
