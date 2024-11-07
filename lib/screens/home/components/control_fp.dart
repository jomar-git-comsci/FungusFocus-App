
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class ControlCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final String action; // 'fan_on', 'fan_off', or 'pump'

  const ControlCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.action,
  });

  @override
  State<ControlCard> createState() => _ControlCardState();
}

class _ControlCardState extends State<ControlCard> {
  bool isPumpActivated = false;
  bool isFanActivated = false;
  final String controlUrl = 'https://gbuy3qfzfemb.connect.remote.it/control';

  // (pump and fan)
  Future<void> toggleDevice() async {
    String deviceAction;
    if (widget.action == 'pump') {
      deviceAction = isPumpActivated ? 'pump_off' : 'pump_on';
      isPumpActivated = !isPumpActivated;
    } else { // widget.action == 'fan'
      deviceAction = isFanActivated ? 'fan_off' : 'fan_on';
      isFanActivated = !isFanActivated;
    }

    try {
      final response = await http.post(
        Uri.parse(controlUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'action': deviceAction}),
      );

      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Update state only if the request was successful
        setState(() {
          if (widget.action == 'pump') {
            isPumpActivated = !isPumpActivated;
          } else {
            isFanActivated = !isFanActivated;
          }
        });
      } else {
        developer.log('Failed with status code: ${response.statusCode}');
        throw Exception('Failed to control device');
      }
    } catch (e) {
      developer.log('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to control device: $e')),
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
              onTap: toggleDevice,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: widget.action == 'pump' 
                      ? (isPumpActivated ? Colors.blue : Colors.red)
                      : (isFanActivated ? Colors.blue : Colors.red),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.action == 'pump'
                        ? (isPumpActivated ? Icons.water_drop : Icons.water_drop_outlined)
                        : (isFanActivated ? Icons.air : Icons.mode_fan_off),
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.action == 'pump'
                          ? (isPumpActivated ? "On" : "Off")
                          : (isFanActivated ? "On" : "Off"),
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
