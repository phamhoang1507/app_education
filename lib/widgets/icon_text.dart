import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final double sizeIcon;
  final double fontSize;

  const IconText({
    required this.text,
    required this.icon,
    required this.color,
    required this.sizeIcon,
    required this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: sizeIcon),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
