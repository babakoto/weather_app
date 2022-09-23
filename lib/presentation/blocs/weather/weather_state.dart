part of 'weather_bloc.dart';

enum WeatherStatus {
  init,
  loading,
  success,
  failure,
}

extension StatusExtension on WeatherStatus {
  bool get isInit => this == WeatherStatus.init;

  bool get isLoading => this == WeatherStatus.loading;

  bool get isSuccess => this == WeatherStatus.success;

  bool get isFailure => this == WeatherStatus.failure;
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final List<Weather> weathers;
  final Failure? failure;

  const WeatherState({
    this.status = WeatherStatus.init,
    this.weathers = const [],
    this.failure,
  });

  @override
  List<Object?> get props => [status, weathers, failure];

  WeatherState copyWith({
    WeatherStatus? status,
    List<Weather>? weathers,
    Failure? failure,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weathers: weathers ?? this.weathers,
      failure: failure ?? this.failure,
    );
  }
}
