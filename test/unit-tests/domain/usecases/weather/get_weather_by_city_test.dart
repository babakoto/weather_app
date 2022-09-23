import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/dto/auth/sign_in_dto.dart';
import 'package:weather_app/core/utils/failure_or_success/fos.dart';
import 'package:weather_app/domain/entities/summary_entity.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/entities/wind.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_by_city.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockSignInDto extends Mock implements SignInDto {}

void main() {
  late GetWeatherByCity getWeatherByCity;
  late MockWeatherRepository weatherRepository;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    getWeatherByCity = GetWeatherByCity(weatherRepository: weatherRepository);
  });

  test('Should return response from signIn in AuthRepository', () async {
    when(() => weatherRepository.findByCity("Paris")).thenAnswer(
      (_) async => const SuccessResponse(
        [
          Weather(
            dt: 11,
            main: SummaryEntity(
              temp: 2.2,
              tempMin: 12.8,
              tempMax: 31.2,
            ),
            wind: Wind(
              speed: 2.2,
              deg: 4.4,
              gust: 5.9,
            ),
            dtTxt: "date",
          ),
        ],
      ),
    );

    final result = await getWeatherByCity(input: "Paris");

    expect(
        result,
        const SuccessResponse(
          [
            Weather(
              dt: 11,
              main: SummaryEntity(
                temp: 2.2,
                tempMin: 12.8,
                tempMax: 31.2,
              ),
              wind: Wind(
                speed: 2.2,
                deg: 4.4,
                gust: 5.9,
              ),
              dtTxt: "date",
            ),
          ],
        ));
  });
}
