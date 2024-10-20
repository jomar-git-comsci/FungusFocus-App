import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SensorCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,  
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),  
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,  
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),  
            const SizedBox(height: 12),
            Text(
              title, 
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold, 
                fontSize: 20,  
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value, 
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18, 
                color: Colors.grey[700],  
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
