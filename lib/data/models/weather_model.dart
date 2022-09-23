import 'package:weather_app/data/models/summery_model.dart';
import 'package:weather_app/data/models/wind_model.dart';
import 'package:weather_app/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.dt,
    required super.main,
    required super.wind,
    required super.dtTxt,
  });

  factory WeatherModel.fromJson(dynamic json) {
    return WeatherModel(
      dt: json['dt'],
      main: SummaryModel.fromJson(json['main']),
      wind: WindModel.fromJson(json['wind']),
      dtTxt: json['dt_txt'],
    );
  }
}
