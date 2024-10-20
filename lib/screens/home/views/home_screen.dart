
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungus_focus/screens/home/blocs/sensor_bloc/sensor_bloc.dart';
import 'package:fungus_focus/screens/home/views/water_screen.dart';
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
                      MaterialPageRoute(builder: (context) => const WaterScreen()),
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
          
          // BlocBuilder to handle WeatherBloc state
          // BlocBuilder<WeatherBloc, WeatherState>(
          //   builder: (context, state) {
          //     developer.log('Building HomeScreen with WeatherState: $state', name: 'HomeScreen');

          //     if (state is WeatherLoading) {
          //       return const SliverFillRemaining(
          //         child: Center(child: CircularProgressIndicator()),
          //       );
          //     } else if (state is WeatherLoaded) {
          //       developer.log('Weather data: ${state.weatherData}', name: 'HomeScreen');

          //       // Safely access the weather data
          //       final humidity = state.weatherData['Humid']?.toString() ?? 'N/A';
          //       final temperature = state.weatherData['Temp']?.toString() ?? 'N/A';

          //       // Display weather data as white box cards
          //       return SliverPadding(
          //         padding: const EdgeInsets.all(15.0),
          //         sliver: SliverGrid(
          //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 2,
          //             mainAxisSpacing: 16,
          //             crossAxisSpacing: 13,
          //             childAspectRatio: 11 / 16,
          //           ),
          //           delegate: SliverChildListDelegate(
          //             [
          //               SensorCard(
          //                 title: 'Humidity',
          //                 value: '$humidity%',
          //                 icon: Icons.water_drop,
          //               ),
          //               SensorCard(
          //                 title: 'Temperature',
          //                 value: '$temperature°C',
          //                 icon: Icons.thermostat,
          //               ),
          //               const SensorCard(
          //                 title: 'Sample',
          //                 value: 'sample',
          //                 icon: Icons.check_box_outline_blank_outlined,
          //               ),
          //               const SensorCard(
          //                 title: 'Sample',
          //                 value: 'sample',
          //                 icon: Icons.check_box_outline_blank_outlined,
          //               ),
          //               const SensorCard(
          //                 title: 'Sample',
          //                 value: 'sample',
          //                 icon: Icons.check_box_outline_blank_outlined,
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //       // delete up if not working
          //       //                 return SliverFillRemaining(
          //       //   child: Center(
          //       //     child: Column(
          //       //       mainAxisAlignment: MainAxisAlignment.center,
          //       //       children: [
          //       //         Text('Humidity: $humidity%'),
          //       //         Text('Temperature: $temperature°C'),
          //       //       ],
          //       //     ),
          //       //   ),
          //       // );
          //     } else if (state is WeatherError) {
          //       developer.log('Weather error: ${state.message}', name: 'HomeScreen');

          //       return SliverFillRemaining(
          //         child: Center(child: Text('Error: ${state.message}')),
          //       );
          //     }

          //     // Default case if no weather data is available
          //     return const SliverFillRemaining(
          //       child: Center(child: Text('No weather data available')),
          //     );
          //   },
          // ),
          // BlocBuilder to handle SensorBloc state
// BlocBuilder<SensorBloc, SensorState>(
//   builder: (context, state) {
//     developer.log('Building HomeScreen with SensorState: $state', name: 'HomeScreen');

//     if (state is SensorLoading) {
//       return const SliverFillRemaining(
//         child: Center(child: CircularProgressIndicator()),
//       );
//     } else if (state is SensorLoaded) {
//       developer.log('Sensor data: ${state.sensorData}', name: 'HomeScreen');

//       // List to store dynamically generated SensorCards
//       List<Widget> sensorCards = [];

//       // Map containing sensor data and respective icons
//       Map<String, IconData> sensorIcons = {
//         'Humid': Icons.water_drop,
//         'Temp': Icons.thermostat,
//         'AirQuality': Icons.air,
//         'WaterLevel': Icons.opacity,
//       };

//       // Loop through the sensorData and dynamically create SensorCards
//       state.sensorData.forEach((sensor, value) {
//         String sensorValue = value?.toString() ?? 'N/A';
//         IconData? sensorIcon = sensorIcons[sensor] ?? Icons.device_unknown; // Use a default icon for unknown sensors
//         sensorCards.add(
//           SensorCard(
//             title: sensor,
//             value: sensorValue,
//             icon: sensorIcon,
//           ),
//         );
//       });

//       // Display sensor data as a grid of SensorCards
//       return SliverPadding(
//         padding: const EdgeInsets.all(15.0),
//         sliver: SliverGrid(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 16,
//             crossAxisSpacing: 13,
//             childAspectRatio: 11 / 16,
//           ),
//           delegate: SliverChildListDelegate(sensorCards), // Use dynamically generated sensorCards
//         ),
//       );
//     } else if (state is SensorError) {
//       developer.log('Sensor error: ${state.message}', name: 'HomeScreen');

//       return SliverFillRemaining(
//         child: Center(child: Text('Error: ${state.message}')),
//       );
//     }

//     // Default case if no sensor data is available
//     return const SliverFillRemaining(
//       child: Center(child: Text('No sensor data available')),
//     );
//   },
// ),
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