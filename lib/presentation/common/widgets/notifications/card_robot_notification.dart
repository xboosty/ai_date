import 'package:flutter/material.dart';

import '../../../../config/config.dart' show Strings;

class CardRobotNotification extends StatelessWidget {
  const CardRobotNotification({
    super.key,
    required this.image,
    required this.title,
    required this.message,
    required this.gradient,
  });

  final String image;
  final Text title;
  final String message;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: size.height * 0.50,
        width: size.width * 0.90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                gradient: gradient,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(image),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      title,
                      SizedBox(height: size.height * 0.03),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF261638),
                          fontSize: 12,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
