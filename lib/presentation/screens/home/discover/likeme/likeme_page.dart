import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../../../../config/config.dart'
    show
        AppTheme,
        CouplesCubit,
        CouplesData,
        CouplesError,
        CouplesInitial,
        CouplesLoading,
        CouplesState,
        Strings;
import '../../../../../domain/domain.dart' show UserEntity;
import '../../../../common/widgets/widgets.dart'
    show
        CardInfoProfile,
        CardProfile,
        CircularOutlineGradientButton,
        PersonalDetail;

class LikeMePage extends StatelessWidget {
  const LikeMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<CouplesCubit, CouplesState>(
              builder: (context, state) => switch (state) {
                CouplesInitial() => const _UserCardLikeMe(
                    couples: [],
                  ),
                CouplesLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                CouplesData() => _UserCardLikeMe(
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

class _UserCardLikeMe extends StatefulWidget {
  const _UserCardLikeMe({required this.couples});

  final List<UserEntity> couples;

  @override
  State<_UserCardLikeMe> createState() => _UserCardLikeMeState();
}

class _UserCardLikeMeState extends State<_UserCardLikeMe> {
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
                // showDragHandle: true,
                // enableDrag: true,
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
                    bloquedButtonAvailable: true,
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
                    gradient: AppTheme.linearGradientTopRightBottomLeft,
                    child: const Icon(Icons.done_rounded, size: 32),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Container(
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
                  image: const DecorationImage(
                    image: AssetImage('assets/imgs/photo_camera_front.png'),
                    fit: BoxFit.contain,
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
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    const Text(
                      'Lives in New York',
                      style: TextStyle(
                        color: Colors.white,
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
    );
  }
}

class _OverviewProfileCard extends StatelessWidget {
  const _OverviewProfileCard({
    required this.size,
    required this.title,
    required this.description,
  });

  final Size size;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return CardInfoProfile(
      width: size.width * 0.95,
      height: size.height * 0.20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF7F87A6),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
