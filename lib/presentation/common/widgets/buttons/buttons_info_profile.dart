import 'package:flutter/material.dart';

import 'profile_button_info.dart';

class ButtonsInfoProfile extends StatelessWidget {
  const ButtonsInfoProfile({
    super.key,
    required this.titleOne,
    required this.titleTwo,
    required this.titleThree,
    required this.iconOne,
    required this.iconTwo,
    required this.iconThree,
  });

  final String titleOne;
  final String titleTwo;
  final String titleThree;

  final IconData iconOne;
  final IconData iconTwo;
  final IconData iconThree;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        ProfileButtonInfo(
          title: titleOne,
          // icon: Icons.cake,
          icon: iconOne,
        ),
        ProfileButtonInfo(
          title: titleTwo,
          icon: iconTwo,
        ),
        ProfileButtonInfo(
          title: titleThree,
          icon: iconThree,
        ),
      ],
    );
  }
}
