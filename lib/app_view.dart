import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungus_focus/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:fungus_focus/splash_screen.dart';

import 'screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'screens/auth/views/welcome_screen.dart';
import 'screens/home/views/home_screen.dart';
import 'dart:developer' as developer;

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FungusFocus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
              surface: Color.fromARGB(255, 48, 114, 50),
              onSurface: Colors.black,
              primary: Colors.green,
              onPrimary: Colors.white,
            )),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            developer.log('Authentication state: ${state.status}', name: 'MyAppView');
            if (state.status == AuthenticationStatus.unknown) {
              return const SplashScreen();
            } else if (state.status == AuthenticationStatus.authenticated) {
              return const HomeScreen();
            } else {
              return BlocProvider(
                create: (context) => SignInBloc(
                  context.read<AuthenticationBloc>().userRepository
                ),
                child: const WelcomeScreen(),  // Initialize sign-in bloc only when unauthenticated
              );
            }
          }),
        ));
  }
}
