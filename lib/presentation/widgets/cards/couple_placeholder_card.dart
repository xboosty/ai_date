import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../../domain/domain.dart' show UserEntity;
import '../widgets.dart' show CircularOutlineGradientButton;

class CouplePlaceHolderCard extends StatelessWidget {
  const CouplePlaceHolderCard({
    super.key,
    required this.user,
    required this.controller,
    required this.assetImage,
    this.isLoader = false,
  });

  final UserEntity user;
  final AppinioSwiperController controller;
  final String assetImage;
  final bool isLoader;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.80,
      height: size.height,
      alignment: Alignment.center,
      // color: Colors.blue,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: AppTheme.linearGradient,
            ),
            child: Container(
              width: size.width * 0.78,
              height: size.height * 0.50,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFEFF0FB),
                image: DecorationImage(
                  image: AssetImage(assetImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        icon: const Icon(
                          Icons.note_add_rounded,
                          color: Color(0xFFD9D9D9),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${user.name} (24)',
                    style: const TextStyle(
                      color: Color(0xFF9CA4BF),
                      fontSize: 22,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    'Lives in New York',
                    style: TextStyle(
                      color: Color(0xFF9CA4BF),
                      fontSize: 12,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      '95% match',
                      style: TextStyle(
                        color: Color(0xFF9CA4BF),
                        fontSize: 12,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularOutlineGradientButton(
                  onTap: isLoader
                      ? () {
                          controller.swipeLeft();
                        }
                      : null,
                  width: 56.0,
                  height: 56.0,
                  child: const Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 209, 70, 15),
                    size: 32,
                  ),
                ),
                SizedBox(width: size.width * 0.30),
                CircularGradientButton(
                  heroTag: 'Like',
                  callback: (isLoader)
                      ? () {
                          controller.swipeRight();
                        }
                      : () {},
                  gradient: AppTheme.linearGradientReverse,
                  child: const Icon(Icons.favorite, size: 32),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
