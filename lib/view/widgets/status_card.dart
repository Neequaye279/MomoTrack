import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String value;
  final String type;
  final IconData icon;
  final Color color;
  const StatusCard({
    super.key,
    required this.value,
    required this.type,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118.0,
      width: 118.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        border: Border.all(color: color.withValues(alpha: 0.12), width: 1.5),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: color, size: 14.0),
          ),
          SizedBox(height: 7.0),
          Text(
            type,
            style: TextStyle(
              color: Color(0xFF8B8D98),
              fontSize: 13.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7.0),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
