import 'package:flutter/material.dart';

import '../widget/drawer_widget.dart';
import '../widget/water_card_screen.dart';
import 'home_screen.dart';

class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

     //TODO try muna UI
      // TODO GAGAWAN NG BLOC PARA SA DATA NA KUKUNIN SA FIREBASE
    final List<Map<String, dynamic>> sensors = [
      {"title": "Water Output", "value": "70%", "icon": Icons.water_drop},
      {"title": "Water SYSTEM", "value": "Automated", "icon": Icons.water_drop},
      //lagay lang kung ilan gusto
    ];


    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          FungusBoxAppBar(scaffoldKey: scaffoldKey, isHomeScreen: false),
          // REST OF THE UI
          // TODO UI para sa water system (automatic or hindi) GAWA NG ANOTHER WIDGET SENSOR CARD FOR WATER SCREEN
          SliverPadding(
            padding: const EdgeInsets.all(15.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 13,
                childAspectRatio: 11 / 16,
              ),
              
        
              // TODO TRY UI 
              
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final sensor = sensors[index];
                  return SensorCardWater( //TODO WATER SENSOR CARD WIDGET
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