import 'package:flutter/material.dart';

import '../../../../config/config.dart' show AppTheme;

class PlaceholderCard extends StatelessWidget {
  const PlaceholderCard({
    super.key,
    required this.assetImage,
  });

  final String assetImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.80,
      height: size.height,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: AppTheme.linearGradient,
        ),
        child: Container(
          width: size.width * 0.78,
          height: size.height * 0.50,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFEFF0FB),
            image: DecorationImage(
              image: AssetImage(assetImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
