import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme;

class CircularProgressIndicatorButton extends StatelessWidget {
  const CircularProgressIndicatorButton({
    super.key,
    required this.onPressed,
    required this.percent,
    required this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final double percent;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 100,
    //   height: 100,
    //   color: Colors.transparent,
    //   child: Stack(alignment: Alignment.center, children: [
    //     SizedBox(
    //       width: 70,
    //       height: 70,
    //       child: CircularProgressIndicator(
    //         backgroundColor: AppTheme.disabledColor,
    //         valueColor: const AlwaysStoppedAnimation<Color>(
    //             Color.fromARGB(255, 204, 66, 24)),
    //         value: percent,
    //         strokeWidth: 3,
    //       ),
    //     ),
    //     Center(
    //       child: FloatingActionButton(
    //         elevation: 0.0,
    //         backgroundColor: backgroundColor,
    //         shape: const CircleBorder(),
    //         onPressed: onPressed,
    //         child: const Icon(Icons.arrow_right_alt,
    //             color: Colors.white, size: 32),
    //       ),
    //     )
    //   ]),
    // );

    return Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.linearGradientReverse,
        ),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
            backgroundColor: Colors.transparent,
          ),
          child:
              const Icon(Icons.arrow_right_alt, color: Colors.white, size: 32),
        )
        // FloatingActionButton(
        //   elevation: 0.0,
        //   backgroundColor: backgroundColor,
        //   shape: const CircleBorder(),
        //   onPressed: onPressed,
        //   child: const Icon(Icons.arrow_right_alt, color: Colors.white, size: 32),
        // ),
        );
  }
}
