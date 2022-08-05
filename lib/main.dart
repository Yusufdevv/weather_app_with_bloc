import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app_bloc/logic/blocs/settings/settings_bloc.dart';
import 'package:weather_app_bloc/logic/blocs/weather/weather_bloc.dart';
import 'package:weather_app_bloc/logic/cubits/settings/settings_cubit.dart';
import 'package:weather_app_bloc/logic/cubits/weather/weather_cubit.dart';
import 'package:weather_app_bloc/logic/repositories/weather_repository.dart';
import 'package:weather_app_bloc/logic/services/http/weather_api_services.dart';
import 'package:weather_app_bloc/presentation/screens/home_screen.dart';
import 'package:weather_app_bloc/presentation/screens/search_screen.dart';
import 'package:weather_app_bloc/presentation/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherApiServices: WeatherApiServices(client: Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) =>
                WeatherCubit(weatherRepository: ctx.read<WeatherRepository>()),
          ),
          BlocProvider(
            create: (ctx) =>
                WeatherBloc(weatherRepository: ctx.read<WeatherRepository>()),
          ),
          BlocProvider(create: (ctx) => SettingsCubit()),
          BlocProvider(create: (ctx) => SettingsBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
          routes: {
            SearchScreen.routeName: (context) => SearchScreen(),
            SettingsScreen.routeName: (context) =>const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
