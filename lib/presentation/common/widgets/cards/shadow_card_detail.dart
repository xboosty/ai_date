import 'package:flutter/material.dart';

import '../../../../config/config.dart' show AppTheme;

class ShadowCardDetail extends StatelessWidget {
  const ShadowCardDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: AppTheme.shadowGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0.0, 0.2),
        ),
      ),
    );
  }
}
