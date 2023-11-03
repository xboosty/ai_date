import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../../../config/config.dart'
    show
        AppTheme,
        BlockCubit,
        CouplesCubit,
        CouplesData,
        CouplesError,
        CouplesInitial,
        CouplesLoading,
        CouplesState,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        getIt;
import '../../../../domain/domain.dart' show UserEntity;
import '../../../widgets/widgets.dart';

import '../../../widgets/widgets.dart'
    show
        ButtonsInfoProfile,
        CardGradientPicture,
        CardInfoProfile,
        CardProfile,
        CircleAvatarProfile,
        CircularOutlineGradientButton;

class SuggestionPage extends StatelessWidget {
  const SuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const _SimilaritySlider(initPercent: 0.0),
        Expanded(
          child: _CouplesProfile(size: size),
        ),
      ],
    );
  }
}

class _CouplesProfile extends StatelessWidget {
  const _CouplesProfile({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size.width,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<CouplesCubit, CouplesState>(
              builder: (context, state) => switch (state) {
                CouplesInitial() => const _UserCard(
                    couples: [],
                  ),
                CouplesLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                CouplesData() => _UserCard(
                    couples: state.couples,
                  ),
                CouplesError() => Container()
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SimilaritySlider extends StatefulWidget {
  const _SimilaritySlider({
    super.key,
    required this.initPercent,
  });

  final double initPercent;

  @override
  State<_SimilaritySlider> createState() => _SimilaritySliderState();
}

class _SimilaritySliderState extends State<_SimilaritySlider> {
  late double percent;

  @override
  void initState() {
    super.initState();
    percent = widget.initPercent;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height * 0.10,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Similarity Slider',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${percent.ceil()} %',
                  style: const TextStyle(
                    color: Color(0xFF6C2EBC),
                    fontSize: 12,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CupertinoSlider(
              value: percent,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  percent = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class _UserCard extends StatefulWidget {
  const _UserCard({required this.couples});

  final List<UserEntity> couples;

  @override
  State<_UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<_UserCard> {
  final AppinioSwiperController controller = AppinioSwiperController();

  final List<String> _hobbies = [
    'Sushi',
    'Books',
    'Basketball',
    'Travel',
    'Movie'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.58,
      child: AppinioSwiper(
        controller: controller,
        cardsCount: 10,
        cardsSpacing: 0.0,
        onSwiping: (AppinioSwiperDirection direction) {
          print(direction.toString());
        },
        cardsBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                builder: (BuildContext context) {
                  return PersonalDetail(
                    user: widget.couples[index],
                    hobbies: _hobbies,
                  );
                },
              );
            },
            child: _CardCouple(
              controller: controller,
              user: widget.couples[index],
            ),
          );
        },
      ),
    );
  }
}

class _CardCouple extends StatelessWidget {
  const _CardCouple({
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
