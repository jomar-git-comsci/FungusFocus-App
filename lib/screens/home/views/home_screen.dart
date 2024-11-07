
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungus_focus/screens/home/blocs/sensor_bloc/sensor_bloc.dart';
import 'package:fungus_focus/screens/home/views/control_screen.dart';
import 'package:fungus_focus/screens/home/components/drawer_widget.dart';

import '../../auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../blocs/sensor_bloc/sensor_state.dart';
import 'dart:developer' as developer;

import '../components/sensor_card.dart';
class FungusBoxAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isHomeScreen;

const FungusBoxAppBar({
    super.key,
    required this.scaffoldKey,
    required this.isHomeScreen,
  });

  @override
  State<FungusBoxAppBar> createState() => _FungusBoxAppBarState();
}

class _FungusBoxAppBarState extends State<FungusBoxAppBar> {
  @override
  Widget build(BuildContext context) {


    // APP BAR or yung Large APP BAR na gumagalaw 
    return SliverAppBar.large(
      leading: IconButton(
        onPressed: () {
          widget.scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(Icons.menu),
        iconSize: 35,
      ),
      title: Column(
        children: [
          const Row(
            children: [
              Icon(
                Icons.sensors,
                size: 35,
              ),
              SizedBox(width: 5),
              Column(
                children: [
                  Text(
                    'FUNGUS BOX DATA',
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  if (!widget.isHomeScreen) {
                    // Puntang HomeScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  if (widget.isHomeScreen) {
                    // Puntang WaterScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ControlScreen()),
                    );
                  }
                },
                icon: const Icon(Icons.tune),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            //LogOut button yung nasa top right
            context.read<SignInBloc>().add(SignOutRequired());
          },
          icon: const Icon(Icons.logout),
        ),
      ],
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(35, 20)),
      ),
    );
  }
}

// HOME SCREEN

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          FungusBoxAppBar(scaffoldKey: _scaffoldKey, isHomeScreen: true),
        
     BlocBuilder<SensorBloc, SensorState>(
            builder: (context, state) {
              if (state is SensorLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is SensorLoaded) {
                List<Widget> sensorCards = [
                  SensorCard(
                    title: 'Air Quality',
                    value: state.sensorData['AirQuality']?['Status'] ?? 'N/A',
                    icon: Icons.air,
                  ),
                  SensorCard(
                    title: 'Water Level',
                    value: state.sensorData['WaterLevel']?['Status'] ?? 'N/A',
                    icon: Icons.opacity,
                  ),
                  
                  SensorCard(
                    title: 'Humidity',
                    value: '${state.sensorData['Weather']?['Humid']?.toString() ?? 'N/A'}%',
                    icon: Icons.water_drop,
                  ),
                  SensorCard(
                    title: 'Temperature',
                    value: '${state.sensorData['Weather']?['Temp']?.toString() ?? 'N/A'}°C',
                    icon: Icons.thermostat,
                  ),
                ];

                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(sensorCards),
                  ),
                );
              } else if (state is SensorError) {
                return SliverFillRemaining(
                  child: Center(child: Text('Error: ${state.message}')),
                );
              }
              return const SliverFillRemaining(
                child: Center(child: Text('No sensor data available')),
              );
            },
          ),
        ],
      ),
    );
  }
}