import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/config.dart';

class NotificationCard extends StatefulWidget {
  final Text title;
  final Text message;
  final double height;
  final double width;
  final Color? color;
  final Icon icon;

  NotificationCard({
    required this.title,
    required this.message,
    required this.height,
    required this.width,
    this.color,
    required this.icon,
  });

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  double _progressValue = 0.0;

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
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            SlideInDown(
              child: AnimatedContainer(
                width: widget.width,
                height: widget.height,
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                duration: const Duration(seconds: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListTile(
                          leading: widget.icon,
                          title: widget.title,
                          subtitle: widget.message,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 1,
                    //   child: Center(
                    //     child: LinearProgressIndicator(),
                    //   ),
                    // ),
                    // SizedBox(height: size.height * 0.01)
                  ],
                ),
                // ElegantNotification.error(
                //   notificationPosition: NotificationPosition.topCenter,
                //   animation: AnimationType.fromTop,
                //   background: const Color(0xFFC02D4F),
                //   showProgressIndicator: true,
                //   // title: const ListTile(
                //   //   leading: Icon(
                //   //     Icons.error_outline,
                //   //     size: 40,
                //   //     color: Colors.white,
                //   //   ),
                //   //   title: Text(
                //   //     'Error',
                //   //     style: TextStyle(
                //   //       color: Colors.white,
                //   //       fontSize: 20,
                //   //       fontFamily: Strings.fontFamily,
                //   //       fontWeight: FontWeight.w700,
                //   //     ),
                //   //   ),
                //   // ),
                //   description: Text(
                //     message,
                //     style: const TextStyle(
                //       color: Colors.black,
                //     ),
                //   ),
                //   onProgressFinished: () => Navigator.of(context).pop(),
                // ),
              ),
            ),
          ],
        ),
      ),
    );

    // Center(
    //   child: AnimatedContainer(
    //     duration: Duration(seconds: 1),
    //     height: 300,
    //     width: 300,
    //     decoration: BoxDecoration(
    //       color: Colors.blue,
    //       borderRadius: BorderRadius.circular(8.0),
    //     ),
    //     child: Column(
    //       children: <Widget>[
    //         Padding(
    //           padding: EdgeInsets.all(8.0),
    //           child: Text(
    //             widget.title,
    //             style:
    //                 TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.all(8.0),
    //           child: Text(
    //             widget.message,
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ),
    //         LinearProgressIndicator(value: _progressValue),
    //       ],
    //     ),
    //   ),
    // );
  }
}
