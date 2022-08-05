import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_bloc/data/models/weather.dart';
import 'package:weather_app_bloc/logic/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<LoadWeatherEvent>(_getWeather);
  }

  Future<void> _getWeather(LoadWeatherEvent event, Emitter<WeatherState> emit ) async {
    emit(WeatherLoading());
    try {
      final weather =await weatherRepository.getWeather(event.city);
      emit(WeatherLoaded(weather));
    } catch (error) {
      emit(WeatherError(error.toString()));
    }
  }
}
