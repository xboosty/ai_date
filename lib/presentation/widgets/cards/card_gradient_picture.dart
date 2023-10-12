import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme;

class CardGradientPicture extends StatelessWidget {
  const CardGradientPicture(
      {super.key, required this.image, this.width, this.height});

  final DecorationImage image;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: AppTheme.linearGradientReverse,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          image: image,
          // const DecorationImage(
          //   image: AssetImage('assets/imgs/girl2.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        // child:
      ),
    );
  }
}
