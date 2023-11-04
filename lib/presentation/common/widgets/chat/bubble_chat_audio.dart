import 'package:flutter/material.dart';

// This widget
class BubbleChatAudio extends StatelessWidget {
  const BubbleChatAudio({
    super.key,
    required this.onPlay,
    required this.controlIcon,
  });

  final VoidCallback onPlay;
  final Icon controlIcon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.89,
      height: size.height * 0.10,
      decoration: const BoxDecoration(
        color: Color(0xFFCCC1EA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          FilledButton(
            onPressed: onPlay,
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: controlIcon,
          ),
        ],
      ),
    );
  }
}
