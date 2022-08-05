import 'package:weather_app_bloc/data/models/weather.dart';
import 'package:weather_app_bloc/logic/services/http/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  WeatherRepository({required this.weatherApiServices});

  Future<Weather> getWeather(String city) async {
    return await weatherApiServices.getWeather(city);
  }
}
