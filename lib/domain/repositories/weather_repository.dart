import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Fos<Failure, List<Weather>>> findByCity(String city);
}
