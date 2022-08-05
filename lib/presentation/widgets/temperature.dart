import 'package:flutter/material.dart';
import 'package:weather_app_bloc/data/models/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/logic/blocs/settings/settings_bloc.dart';
class TemperaturePart extends StatefulWidget {
  const TemperaturePart({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  State<TemperaturePart> createState() => _TemperaturePartState();
}

class _TemperaturePartState extends State<TemperaturePart> {
  
  String _showTemperature(double temp) {
    final tempUnit = context.watch<SettingsBloc>().state.tempUnits;

    if(tempUnit == TempUnits.fahrenheit) {
      return '${(temp * 9/5 +32).toStringAsFixed(0)} ℉';
    } 
    return '${temp.toStringAsFixed(0)} ℃';
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _showTemperature(widget.weather.temp),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 70,
              height: 0.1),
        ),
        Row(
          children: [
            Image.network(
                'https://openweathermap.org/img/wn/${widget.weather.icon}.png'),
            Text(
              widget.weather.main,
              style: const TextStyle(
                  color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }
}