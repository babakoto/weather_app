import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entities/summary_entity.dart';

import 'wind.dart';

class Weather extends Equatable {
  final int dt;
  final SummaryEntity main;
  final Wind wind;
  final String dtTxt;

  const Weather({
    required this.dt,
    required this.main,
    required this.wind,
    required this.dtTxt,
  });

  @override
  List<Object> get props => [dt, main, wind, dtTxt];
}
