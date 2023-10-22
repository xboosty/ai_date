import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'card_robot_notification.dart';
import '../../../config/config.dart' show Strings;

class RobotSuccessNotification extends StatefulWidget {
  const RobotSuccessNotification({
    super.key,
    required this.message,
  });

  final String message;

  @override
  State<RobotSuccessNotification> createState() =>
      _RobotSuccessNotificationState();
}

class _RobotSuccessNotificationState extends State<RobotSuccessNotification> {
  @override
  void initState() {
    super.initState();

    // Iniciar una temporización para mostrar la notificación durante 1 segundo.
    Timer(const Duration(seconds: 2), () {
      // setState(() {
      //   _progressValue = 1.0;
      // });

      //   // Luego, después de 1 segundo, ocultar la notificación.
      // Timer(Duration(seconds: 1), () {
      Navigator.of(context).pop();
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      child: FadeIn(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardRobotNotification(
                image: 'assets/imgs/success_robot.png',
                title: const Text(
                  'Success!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF00BD62),
                    fontSize: 26,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                message: widget.message,
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFF00E492), Color(0xFF422EBC)],
                ),
              ),
              // SizedBox(height: size.height * 0.03),
              // SizedBox(
              //   child: FilledButton(
              //     onPressed: () {},
              //     style: FilledButton.styleFrom(
              //       backgroundColor: const Color(0xFF00BD62),
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         const Text(
              //           'CONTINUE',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16,
              //             fontFamily: Strings.fontFamily,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         SizedBox(width: size.width * 0.01),
              //         const Icon(Icons.arrow_forward)
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
