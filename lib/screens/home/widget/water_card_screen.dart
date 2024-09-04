import 'package:flutter/material.dart';

class SensorCardWater extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SensorCardWater({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });
  
  // TODO SENSOR WATER CARD UI
  // SENSOR CARD NG HOMESCREEN PERO PWEDE KO RIN ILAGAY SA WATER SCREEN ? 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
            blurRadius: 3,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Icon(icon, size: 30),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
