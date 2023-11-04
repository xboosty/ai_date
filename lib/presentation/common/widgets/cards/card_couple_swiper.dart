import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../../../config/config.dart' show AppTheme;
import '../../../../domain/domain.dart' show UserEntity;
import '../buttons/circular_outline_gradient_button.dart';
import 'card_profile.dart';
import 'couple_placeholder_card.dart';

class CardCoupleSwiper extends StatelessWidget {
  const CardCoupleSwiper({
    super.key,
    required this.controller,
    required this.user,
  });

  final AppinioSwiperController controller;
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CachedNetworkImage(
      imageUrl: user.avatar,
      imageBuilder: (context, imageProvider) => Container(
        width: size.width * 0.80,
        height: size.height,
        alignment: Alignment.topCenter,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            CardProfile(
              user: user,
              imageProvider: imageProvider,
            ),
            Positioned(
              bottom: -25.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularOutlineGradientButton(
                    onTap: () {
                      controller.swipeLeft();
                    },
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
                    callback: () {
                      controller.swipeRight();
                    },
                    gradient: AppTheme.linearGradientReverse,
                    child: const Icon(Icons.favorite, size: 32),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      placeholder: (context, url) => CouplePlaceHolderCard(
        user: user,
        controller: controller,
        assetImage: 'assets/imgs/loading.gif',
      ),
      errorWidget: (context, url, error) => CouplePlaceHolderCard(
        user: user,
        controller: controller,
        assetImage: 'assets/imgs/no-image.jpg',
      ),
    );
  }
}
