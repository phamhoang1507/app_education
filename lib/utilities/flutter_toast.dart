import 'package:flutter/material.dart';

void showToast(
  BuildContext context,
  String text, {
  Duration duration = const Duration(seconds: 3),
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
      ),
      duration: duration,
    ),
  );
}
