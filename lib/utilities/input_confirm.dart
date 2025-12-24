import 'package:education_app/extensions/l10n.dart';
import 'package:flutter/material.dart';

Future<String?> inputConfirm(
  BuildContext context,
  String text,
  String label,
) async {
  final controller = TextEditingController();
  final l10n = context.l10n;

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(l10n.continueText),
          ),
        ],
      );
    },
  );
}
