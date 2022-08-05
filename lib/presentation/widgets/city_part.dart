import 'package:flutter/material.dart';
import 'package:weather_app_bloc/data/models/weather.dart';
import '../../helpers/extensions/string_extensions.dart';

class CityPart extends StatelessWidget {
  const CityPart({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weather.city.capitizeString(),
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 50),
        ),
        Text(
          weather.desc,
          style: const TextStyle(
              color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}