import 'package:equatable/equatable.dart';

class Wind extends Equatable {
  final double speed;
  final double deg;
  final double gust;

  const Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  @override
  List<Object> get props => [speed, deg, gust];
}
