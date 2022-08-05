import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/logic/blocs/settings/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const String routeName = '/setttings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen'),
      ),
      body: ListTile(
        title: const Text('Temperature Unit'),
        subtitle: const Text('Temperature / Fahrenheit(by default: Celcius'),
        trailing: Switch.adaptive(
          value: context.watch<SettingsBloc>().state.tempUnits==TempUnits.celcius ? true : false,
          onChanged: (value) {
            context.read<SettingsBloc>().add(ToggleTemperatureEvent());
          },
        ),
      ),
    );
  }
}
