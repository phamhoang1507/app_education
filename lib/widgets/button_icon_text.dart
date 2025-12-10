import 'package:flutter/material.dart';

class ButtonIconText extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double sizeIcon;
  final double fontSize;

  const ButtonIconText({
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.sizeIcon,
    required this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Row(
          children: [
            Icon(icon, color: color, size: sizeIcon),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
