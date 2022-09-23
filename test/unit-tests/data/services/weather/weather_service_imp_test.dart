import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/data/models/token_model.dart';
import 'package:weather_app/data/services/environment/environment_service.dart';
import 'package:weather_app/data/services/network/network_service.dart';
import 'package:weather_app/data/services/weather/weather_service_imp.dart';

class MockDio extends Mock implements Dio {}

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ""));
    registerFallbackValue(const TokenModel(assessToken: "", tokenType: ""));
  });

  late MockDio dio;
  late WeatherServiceImp weatherServiceImp;
  late MockNetworkService networkService;

  setUp(() async {
    await EnvironmentService.config();
    dio = MockDio();
    networkService = MockNetworkService();
    weatherServiceImp =
        WeatherServiceImp(dio: dio, networkService: networkService);
  });
}
