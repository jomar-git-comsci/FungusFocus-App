import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:fungus_focus/screens/home/blocs/sensor_bloc/sensor_bloc.dart';
import 'dart:developer' as developer;

import 'app_view.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'screens/home/blocs/sensor_bloc/sensor_state.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            developer.log('Creating AuthenticationBloc', name: 'MyApp');
            return AuthenticationBloc(userRepository: userRepository);
          },
        ),
        BlocProvider<SensorBloc>(
          create: (context) {
            developer.log('Creating WeatherBloc', name: 'MyApp');
            return SensorBloc();
          },
        ),
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          developer.log('AuthenticationState changed: $state', name: 'MyApp');
        },
        child: BlocListener<SensorBloc, SensorState>(
          listener: (context, state) {
            developer.log('WeatherState changed: $state', name: 'MyApp');
          },
          child: const MyAppView(),
        ),
      ),
    );
  }
}