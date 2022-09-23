import 'package:weather_app/data/models/weather_model.dart';

abstract class WeatherService {
  Future<List<WeatherModel>> findByCity({required String city});
}
