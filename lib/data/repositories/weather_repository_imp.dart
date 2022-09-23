import 'package:weather_app/core/errors/exceptions/exceptions.dart';
import 'package:weather_app/core/errors/failures/all_failure.dart';
import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/data/services/weather/weather_service.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImp implements WeatherRepository {
  final WeatherService weatherService;

  @override
  Future<Fos<Failure, List<Weather>>> findByCity(String city) async {
    try {
      final weathers = await weatherService.findByCity(city: city);
      return SuccessResponse(weathers);
    } on UnauthorizedException catch (e) {
      return FailureResponse(
        UnauthorizedFailure(code: e.code, message: e.message),
      );
    } on NetworkException catch (e) {
      return FailureResponse(
        NetworkFailure(code: e.code, message: e.message),
      );
    } on ServerException catch (e) {
      return FailureResponse(
        ServerFailure(code: e.code, message: e.message),
      );
    } catch (e) {
      return const FailureResponse(
        UnknownFailure(
          message: "unknownException SignIn",
        ),
      );
    }
  }

  const WeatherRepositoryImp({
    required this.weatherService,
  });
}
