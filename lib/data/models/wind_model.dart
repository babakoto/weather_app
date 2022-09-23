import 'package:weather_app/domain/entities/wind.dart';

class WindModel extends Wind {
  const WindModel(
      {required super.speed, required super.deg, required super.gust});

  factory WindModel.fromJson(Map<String, dynamic> map) {
    return WindModel(
      speed: map['speed'].toDouble(),
      deg: map['deg'].toDouble(),
      gust: map['gust'].toDouble(),
    );
  }
}
