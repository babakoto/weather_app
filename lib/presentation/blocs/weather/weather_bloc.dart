import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/utils/failure_or_success/failure.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_by_city.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherByCity getWeatherByCity;

  WeatherBloc({required this.getWeatherByCity}) : super(const WeatherState()) {
    on<OnFetchWeather>(_onFetch);
  }

  FutureOr<void> _onFetch(
      OnFetchWeather event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    final result = await getWeatherByCity(input: event.city);

    result.on((failure) {
      emit(state.copyWith(status: WeatherStatus.failure, failure: failure));
    }, (success) {
      emit(state.copyWith(
          status: WeatherStatus.success, weathers: success, failure: null));
    });
  }
}
