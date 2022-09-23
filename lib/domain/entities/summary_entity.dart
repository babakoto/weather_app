import 'package:equatable/equatable.dart';

class SummaryEntity extends Equatable {
  final double temp;
  final double tempMin;
  final double tempMax;

  const SummaryEntity({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  @override
  List<Object> get props => [temp, tempMin, tempMax];
}
