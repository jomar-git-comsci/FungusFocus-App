import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(255, 48, 114, 50), Color.fromARGB(255, 5, 5, 5)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(
              Icons.grass,
              size: 100.0,
              color: Colors.white,
            ),],
            ),
        ),
        );
  }
}