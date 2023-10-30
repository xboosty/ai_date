import 'package:flutter/material.dart';

class NavigationsApp {
  void nextPage({required PageController pageviewController}) {
    pageviewController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void backPage(BuildContext context,
      {required PageController pageviewController}) {
    FocusScope.of(context).unfocus();
    pageviewController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void exitSetup(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }
}
