import 'package:flutter/material.dart';

class ProfileButtonInfo extends StatelessWidget {
  const ProfileButtonInfo({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.30,
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0x336D2EBC),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.purple,
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF6C2EBC),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
