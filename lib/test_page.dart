import 'package:flutter/material.dart';

import 'config/config.dart';
import 'presentation/widgets/widgets.dart' show CardRobotNotification;

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  static const String routeName = '/test';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(),
    );
  }
}
