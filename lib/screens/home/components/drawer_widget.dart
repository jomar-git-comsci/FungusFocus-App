// lib/widgets/custom_drawer.dart
import 'package:flutter/material.dart';
import 'package:fungus_focus/screens/home/views/video_camera.dart';
import 'package:fungus_focus/screens/home/views/water_screen.dart';

import '../views/home_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text(
                  'Fungus Box',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontStyle: FontStyle.italic
                  ),
                ),
                Text(
                  'Automatic Sensor for Mushroom',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic
                  ),
                ),
                
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white,),
            title: const Text('Home', style: TextStyle(
              color: Colors.white,
            ),),
            onTap: () {

              // navigate to home screen
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              ); 
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.tune, color: Colors.white,),
            title: const Text('Manual', style: TextStyle(
              color: Colors.white,
            ),),
            onTap: () {

              // navigate to water screen
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WaterScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.white,),
            title: const Text('Camera', style: TextStyle(
              color: Colors.white,
            ),),
            onTap: () { 

                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const VideoStreamPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
