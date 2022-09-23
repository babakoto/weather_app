import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/core/utils/usecase/usecase.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class GetWeatherByCity implements UseCase<String, List<Weather>> {
  final WeatherRepository weatherRepository;

  const GetWeatherByCity({
    required this.weatherRepository,
  });

  @override
  Future<Fos<Failure, List<Weather>>> call({required String input}) {
    return weatherRepository.findByCity(input);
  }
}
