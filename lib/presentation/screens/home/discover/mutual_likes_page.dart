import 'package:flutter/material.dart';

import '../../../../config/config.dart' show AppTheme, Strings;

class MutualLikesPage extends StatelessWidget {
  const MutualLikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [
          _TitleMutualLikes(size: size),
          _GridMutualLikeProfile(size: size),
        ],
      ),
    );
  }
}

class _GridMutualLikeProfile extends StatelessWidget {
  const _GridMutualLikeProfile({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.3,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            gradient: AppTheme.linearGradientTopRightBottomLeft,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              image: const DecorationImage(
                image: AssetImage('assets/imgs/girl5.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [_ButtonHand()],
                  ),
                ),
                const Spacer(),
                const Text(
                  'Jennifer (24)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Lives in New York',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.03)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonHand extends StatelessWidget {
  const _ButtonHand({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.linearGradientTopRightBottomLeft),
      child: const Center(
        child: Icon(
          Icons.waving_hand_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _TitleMutualLikes extends StatelessWidget {
  const _TitleMutualLikes({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Ready to make a connection?\n',
              style: TextStyle(
                color: Color(0xFF261638),
                fontSize: 16,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text:
                  'Say Hi to your mutual likes and spark some conversations today!',
              style: TextStyle(
                color: Color(0xFF686E8C),
                fontSize: 16,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
