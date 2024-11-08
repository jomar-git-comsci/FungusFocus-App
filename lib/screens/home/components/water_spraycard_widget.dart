
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WaterSprayCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  const WaterSprayCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  State<WaterSprayCard> createState() => _WaterSprayCardState();
}

class _WaterSprayCardState extends State<WaterSprayCard> {
  bool isSpraying = false;
  
   final String remoteItUrl = 'https://gbuy3qfzfemb.connect.remote.it/control';

  Future<void> togglePump() async {
    try {
      final response = await http.post(
        Uri.parse('$remoteItUrl/activate_pump'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        setState(() {
          isSpraying = true;
        });
        
        // Automatically turn off after 2 seconds
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          isSpraying = false;
        });
      } else {
        throw Exception('Failed to activate pump');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to control pump: $e')),
      );
    }
  }


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
            Icon(widget.icon, size: 50, color: Colors.blueAccent),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: togglePump,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: isSpraying ? Colors.blue : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSpraying ? Icons.water_drop : Icons.water_drop_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isSpraying ? "On" : "Off",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}