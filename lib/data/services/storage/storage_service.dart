import 'package:weather_app/data/models/token_model.dart';

abstract class StorageService {
  Future<bool> cached({TokenModel? token});
  Future<TokenModel?> getToken();
  Future<bool> removeToken();
}
