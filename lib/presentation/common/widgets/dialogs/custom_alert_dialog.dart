import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedCancel,
    required this.onPressedOk,
  });

  final String title;
  final String content;
  final VoidCallback? onPressedCancel;
  final VoidCallback? onPressedOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.info_outline_rounded,
        size: 40,
      ),
      title: Text(title),
      content: Text(content),
      actions: [
        FilledButton(
          onPressed: onPressedCancel,
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: onPressedOk,
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
