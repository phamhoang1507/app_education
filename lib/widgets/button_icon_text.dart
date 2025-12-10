import 'package:education_app/widgets/icon_text.dart';
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
        child: IconText(text: text, icon: icon, color: color, sizeIcon: sizeIcon, fontSize: fontSize)
      ),
    );
  }
}
