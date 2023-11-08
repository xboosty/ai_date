import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import '../../../../common/widgets/widgets.dart';

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
                CouplesData() => state.couples.isNotEmpty
                    ? _UserCard(
                        couples: state.couples,
                      )
                    : const Center(
                        child: Text('There are no couples available'),
                      ),
                CouplesError() => const Center(
                    child: Text(
                        'Oops!! An error occurred while loading the images'),
                  ),
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
                    bloquedButtonAvailable: true,
                  );
                },
              );
            },
            child: CardCoupleSwiper(
              controller: controller,
              user: widget.couples[index],
            ),
          );
        },
      ),
    );
  }
}
