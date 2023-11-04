import 'package:flutter/material.dart';

import '../../../../../config/config.dart' show AppTheme, Strings;
import '../../../../common/widgets/widgets.dart' show GradientText;

class TitleUnblockUser extends StatelessWidget {
  const TitleUnblockUser({
    super.key,
    required this.size,
    required this.name,
  });

  final Size size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.10,
      decoration: BoxDecoration(
        gradient: AppTheme.shadowGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text(
          'Lives in New York',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.6000000238418579),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          child: const GradientText(
            text: '95% match',
            gradient: AppTheme.linearGradient,
            style: TextStyle(
              fontSize: 12,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
