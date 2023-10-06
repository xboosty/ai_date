import 'package:flutter/material.dart';

import '../../../config/config.dart' show Strings;

class VisibleOnProfile extends StatefulWidget {
  const VisibleOnProfile({
    super.key,
    required this.isVisible,
  });

  final bool isVisible;

  @override
  State<VisibleOnProfile> createState() => _VisibleOnProfileState();
}

class _VisibleOnProfileState extends State<VisibleOnProfile> {
  late bool isVisibleState;

  @override
  void initState() {
    super.initState();
    isVisibleState = widget.isVisible;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text(
        'Visible on profile',
        style: TextStyle(
          color: Color(0xFF261638),
          fontSize: 14,
          fontFamily: Strings.fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
      value: isVisibleState,
      onChanged: (bool? value) {
        setState(() {
          isVisibleState = value ?? false;
        });
      },
    );
  }
}
