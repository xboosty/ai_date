import 'package:flutter/material.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';

import '../constants/strings.dart';

class HandlerNotification {
  void errorDioNotification(BuildContext context) {
    ElegantNotification.error(
      notificationPosition: NotificationPosition.topCenter,
      animation: AnimationType.fromTop,
      background: Colors.red.shade100,
      showProgressIndicator: true,
      title: const SizedBox(
        width: 164.58,
        child: Text(
          'Error',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      description: const Text(
        'Connection error',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ).show(context);
  }

  void ntsErrorNotification(BuildContext context,
      {required String title, required String message}) {
    ElegantNotification.error(
      notificationPosition: NotificationPosition.bottomCenter,
      animation: AnimationType.fromBottom,
      background: Colors.red.shade100,
      showProgressIndicator: true,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      description: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ).show(context);
  }

  void ntsSuccessNotification(BuildContext context,
      {required String title, required String message}) {
    ElegantNotification.success(
      notificationPosition: NotificationPosition.topCenter,
      animation: AnimationType.fromTop,
      background: Colors.green.shade100,
      showProgressIndicator: true,
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      description: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ).show(context);
  }
}
