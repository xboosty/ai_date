import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../../config/config.dart' show Strings;
import 'card_robot_notification.dart';

class RobotErrorNotification extends StatefulWidget {
  const RobotErrorNotification({
    super.key,
    required this.message,
  });

  final String message;

  @override
  State<RobotErrorNotification> createState() => _RobotErrorNotificationState();
}

class _RobotErrorNotificationState extends State<RobotErrorNotification> {
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
      duration: const Duration(seconds: 1),
      child: FadeIn(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardRobotNotification(
                image: 'assets/imgs/error_robot.png',
                title: const Text(
                  'Oops!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFC02D4F),
                    fontSize: 26,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                message: widget.message,
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFFED5C3B), Color(0xFFC02D4F)],
                ),
              ),
              // SizedBox(height: size.height * 0.03),
              // SizedBox(
              //   child: FilledButton(
              //     onPressed: () {},
              //     style: FilledButton.styleFrom(
              //       backgroundColor: const Color(0xFFC02D4F),
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         const Text(
              //           'TRY AGAIN',
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
