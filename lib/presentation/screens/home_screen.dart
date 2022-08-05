import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/logic/blocs/weather/weather_bloc.dart';
import 'package:weather_app_bloc/presentation/widgets/city_part.dart';
import 'package:weather_app_bloc/presentation/widgets/temperature.dart';
import 'package:weather_app_bloc/presentation/widgets/weather_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getWeather('london');
  }

  void _getWeather(String city) {
    // context.read<WeatherCubit>().getWeather(city);
    context.read<WeatherBloc>().add(LoadWeatherEvent(city));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (ctx, state) async {
          if (state is WeatherError) {
            await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Error'),
                content: Text(state.message),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OKAY'))
                ],
              ),
            );
            if (state.message.toLowerCase().contains('not found')) {
              _getWeather('london');
            }
          }
        },
        builder: (context, state) {
          if (state is WeatherInitial) {
            return const Center(
              child: Text('Choose city'),
            );
          } else if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final weather = state.weather;
            final mainWeather = weather.main.toLowerCase();
            String imagePath = '';

            if (mainWeather.contains('rain')) {
              imagePath = 'assets/rainy.jpg';
            } else if (mainWeather.contains('cloud')) {
              imagePath = 'assets/cloudy.jpg';
            } else if (mainWeather.contains('sun')) {
              imagePath = 'assets/sunny.jpg';
            } else {
              imagePath = 'assets/night.jpg';
            }
            return Stack(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                ),
                Positioned(
                  top: 40,
                  right: 0,
                  child: WeatherMenu(
                    getWeather: _getWeather,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CityPart(weather: weather),
                        TemperaturePart(weather: weather),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}


