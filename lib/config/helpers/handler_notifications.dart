import 'package:flutter/material.dart';
export 'package:dio/dio.dart' show DioException;

import '../../presentation/common/widgets/widgets.dart'
    show NotificationCard, RobotErrorNotification, RobotSuccessNotification;
import '../constants/strings.dart';

class HandlerNotification {
  Future<void> ntsErrorNotification(
    BuildContext context, {
    required String message,
    required double height,
    required double width,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => NotificationCard(
        icon: const Icon(
          Icons.error_outline,
          size: 30,
          color: Colors.white,
        ),
        title: const Text(
          'Error',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        message: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
        width: width,
        height: height,
        color: const Color(0xFFC02D4F),
      ),
    );
  }

  Future<void> ntsSuccessNotification(
    BuildContext context, {
    required String message,
    required double height,
    required double width,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => NotificationCard(
        icon: const Icon(
          Icons.check_circle_outline,
          size: 30,
          color: Colors.white,
        ),
        title: const Text(
          'Success!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        message: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
        width: width,
        height: height,
        color: const Color(0xFF00BD62),
      ),
    );
  }

  Future<void> successRobotNotification(BuildContext context,
      {required String message}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return RobotSuccessNotification(
          message: message,
        );
      },
    );
  }

  Future<void> errorRobotNotification(BuildContext context,
      {required String message}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return RobotErrorNotification(
          message: message,
        );
      },
    );
  }
}
