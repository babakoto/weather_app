import 'package:weather_app/domain/entities/summary_entity.dart';

class SummaryModel extends SummaryEntity {
  const SummaryModel(
      {required super.temp, required super.tempMin, required super.tempMax});

  factory SummaryModel.fromJson(dynamic json) {
    return SummaryModel(
      temp: json['temp'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
    );
  }
}
