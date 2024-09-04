
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fungus_focus/screens/home/views/water_screen.dart';
import 'package:fungus_focus/screens/home/widget/drawer_widget.dart';

import '../../auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../widget/sensor_card.dart';
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
                icon: const Icon(Icons.water_drop),
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

      //TODO try muna UI
      // TODO GAGAWAN NG BLOC PARA SA DATA NA KUKUNIN SA FIREBASE
    final List<Map<String, dynamic>> sensors = [
      {"title": "Moisture", "value": "80%", "icon": Icons.opacity},
      {"title": "Light", "value": "300 lx", "icon": Icons.wb_sunny},
      {"title": "Air Quality", "value": "Good", "icon": Icons.air},
      {"title": "Temperature", "value": "25°C", "icon": Icons.thermostat},
      {"title": "Humidity", "value": "70%", "icon": Icons.water_rounded},
      //lagay lang kung ilan gusto
    ];



    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          FungusBoxAppBar(scaffoldKey: _scaffoldKey, isHomeScreen: true),


          // REST OF THE UI  
          // TODO dito mag edit nung para sa container na white
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 13,
                childAspectRatio: 11 / 16, // SHAPE NUNG CONTAINER
              ),
              
        
              // TODO TRY UI 
              
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final sensor = sensors[index];
                  return SensorCard( //TODO SENSOR CARD WIDGET EXTENSTION OF HOMESCREEN
                    title: sensor["title"],
                    value: sensor["value"],
                    icon: sensor["icon"],
                  );
                  // TATAWAGIN YUG NASA TAAS NA DATA TAPOS YUNG UI NG CARD NASA IBANG FILE
                },
                childCount: sensors.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}