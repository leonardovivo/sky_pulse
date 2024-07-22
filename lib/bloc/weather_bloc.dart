import 'package:bloc/bloc.dart';
import 'package:sky_pulse/services/weather_service.dart';
import 'package:sky_pulse/models/weather_model.dart';

abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String cityName;

  FetchWeather({required this.cityName});
}

abstract class WeatherState {
  get message => null;

  get weather => null;
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({required this.weather});
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc({required this.weatherService}) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await weatherService.fetchWeatherByCityName(event.cityName);
        emit(WeatherLoaded(weather: weather));
      } catch (e) {
        emit(WeatherError(message: e.toString()));
      }
    });
  }
}
