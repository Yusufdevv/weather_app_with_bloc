import 'package:flutter/material.dart';
import 'package:weather_app_bloc/presentation/screens/search_screen.dart';
import 'package:weather_app_bloc/presentation/screens/settings_screen.dart';

class WeatherMenu extends StatelessWidget {
  final Function getWeather;
  const WeatherMenu({required this.getWeather, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final cityName =
                await Navigator.of(context).pushNamed(SearchScreen.routeName);
            if (cityName != null) {
              getWeather(cityName as String);
            }
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }
}