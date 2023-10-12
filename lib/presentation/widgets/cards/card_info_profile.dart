import 'package:flutter/material.dart';

class CardInfoProfile extends StatelessWidget {
  const CardInfoProfile(
      {super.key, this.child, required this.width, required this.height});

  final double width;
  final double height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}
