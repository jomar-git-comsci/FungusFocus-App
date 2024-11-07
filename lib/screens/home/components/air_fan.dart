
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VentilationCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;

  const VentilationCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  State<VentilationCard> createState() => _VentilationCardState();
}

class _VentilationCardState extends State<VentilationCard> {
  bool isFanning = false;

final String remoteItUrl = 'https://gbuy3qfzfemb.connect.remote.it/control';

  Future<void> toggleFan() async {
    try {
      if (!isFanning) {
        final response = await http.post(
          Uri.parse('$remoteItUrl/activate_fan'),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 200) {
          setState(() {
            isFanning = true;
          });
        } else {
          throw Exception('Failed to activate fan');
        }
      } else {
        final response = await http.post(
          Uri.parse('$remoteItUrl/deactivate_fan'),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 200) {
          setState(() {
            isFanning = false;
          });
        } else {
          throw Exception('Failed to deactivate fan');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to control fan: $e')),
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
              onTap: toggleFan,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: isFanning ? Colors.blue : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isFanning ? Icons.air : Icons.mode_fan_off,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isFanning ? "On" : "Off",
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