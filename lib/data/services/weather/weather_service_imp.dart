import 'package:dio/dio.dart';
import 'package:weather_app/core/errors/exceptions/exceptions.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/services/environment/environment_service.dart';
import 'package:weather_app/data/services/network/network_service.dart';
import 'package:weather_app/data/services/weather/weather_service.dart';

class WeatherServiceImp implements WeatherService {
  final Dio _dio;
  final NetworkService _networkService;

  @override
  Future<List<WeatherModel>> findByCity({required String city}) async {
    try {
      if (await _networkService.hasConnexion) {
        final response = await _dio.get(
            "${EnvironmentService.host}?q=$city&appid=${EnvironmentService.apiKey}&lang=fr&units=metric");
        final data = response.data["list"];
        final List<WeatherModel> weathers = (data as List)
            .map((weather) => WeatherModel.fromJson(weather))
            .toList();
        return weathers;
      } else {
        throw const NetworkException();
      }
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw const UnauthorizedException();
        case 500:
          throw const ServerException();
        default:
          throw UnknownException(message: "$e");
      }
    }
  }

  WeatherServiceImp({
    required Dio dio,
    required NetworkService networkService,
  })  : _dio = dio,
        _networkService = networkService;
}
