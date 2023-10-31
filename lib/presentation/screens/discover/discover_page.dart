import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../../../config/config.dart'
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
import '../../../domain/domain.dart' show UserEntity;
import '../../widgets/widgets.dart'
    show
        ButtonsInfoProfile,
        CardGradientPicture,
        CardInfoProfile,
        CardProfile,
        CircleAvatarProfile,
        CircularOutlineGradientButton;

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  static const String routeName = '/discover';

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> tabs = const <Widget>[
    Tab(
      height: 80,
      // text: 'Flights',
      child: IconButtonTitle(
        message: 'Suggest',
        icon: Icon(Icons.settings_suggest),
      ),
      // child: IconButtonTitle(),
    ),
    Tab(
      height: 80,
      // text: 'Flights',
      child: IconButtonTitle(
        message: 'Mutual Likes',
        icon: Icon(Icons.favorite_border_outlined),
      ),
      // child: IconButtonTitle(),
    ),
    Tab(
      height: 80,
      // text: 'Flights',
      child: IconButtonTitle(
        message: 'Like me',
        icon: Icon(Icons.tag),
      ),
      // child: IconButtonTitle(),
    ),
    Tab(
      height: 80,
      // text: 'Flights',
      child: IconButtonTitle(
        message: 'Like sent',
        icon: Icon(Icons.supervisor_account),
      ),
      // child: IconButtonTitle(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: tabs.length, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 28,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          const Icon(Icons.tune, color: Colors.grey),
          SizedBox(width: size.width * 0.04),
        ],
        bottom: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                const _SimilaritySlider(initPercent: 0.0),
                Container(
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
              ],
            ),
          ),
          Center(child: Text('Trips')),
          Center(child: Text('Explore')),
          Center(child: Text('Explore')),
        ],
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

class IconButtonTitle extends StatelessWidget {
  const IconButtonTitle({
    super.key,
    required this.message,
    required this.icon,
  });

  final String message;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: null,
          style: IconButton.styleFrom(
            disabledBackgroundColor: const Color(0x3F6C2EBC),
          ),
          icon: icon,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            fontFamily: Strings.fontFamily,
            // fontWeight: FontWeight.w600,
          ),
        )
      ],
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
                  return DraggableScrollableSheet(
                    initialChildSize: 1.0,
                    minChildSize: 1.0,
                    maxChildSize: 1.0,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              _CardSeeProfileDetails(
                                user: widget.couples[index],
                              ),
                              SizedBox(height: size.height * 0.02),
                              _SmallDescriptionProfile(size: size),
                              const ButtonsInfoProfile(
                                titleOne: '31 years old',
                                titleTwo: '165 cm',
                                titleThree: 'Virgo',
                                iconOne: Icons.cake,
                                iconTwo: Icons.straighten,
                                iconThree: Icons.calendar_month,
                              ),
                              CardGradientPicture(
                                image: const DecorationImage(
                                  image: AssetImage('assets/imgs/girl2.png'),
                                  fit: BoxFit.cover,
                                ),
                                width: size.width * 0.90,
                                height: size.height * 0.55,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'Personal questions & background',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF6C2EBC),
                                    fontSize: 18,
                                    fontFamily: Strings.fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const ButtonsInfoProfile(
                                titleOne: 'Vaccinated',
                                titleTwo: 'Sometimes',
                                titleThree: 'No',
                                iconOne: Icons.vaccines,
                                iconTwo: Icons.smoking_rooms,
                                iconThree: Icons.medication,
                              ),
                              _PersonalQuestionInfo(size: size),
                              SizedBox(height: size.height * 0.02),
                              _OthersPicturesProfile(size: size),
                              const Padding(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'Interests & lifestyle',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF6C2EBC),
                                    fontSize: 18,
                                    fontFamily: Strings.fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _HobbiesProfile(size: size, hobbies: _hobbies),
                              SizedBox(height: size.height * 0.02),
                              CardInfoProfile(
                                width: size.width * 0.95,
                                height: size.height * 0.42,
                                child: const Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.eco,
                                        color: Color(0xFFD9D9D9),
                                      ),
                                      title: Text(
                                        'Vegetarian',
                                        style: TextStyle(
                                          color: Color(0xFF7F87A6),
                                          fontSize: 14,
                                          fontFamily: Strings.fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      leading: Icon(
                                        Icons.fitness_center,
                                        color: Color(0xFFD9D9D9),
                                      ),
                                      title: Text(
                                        'Vegetarian',
                                        style: TextStyle(
                                          color: Color(0xFF7F87A6),
                                          fontSize: 14,
                                          fontFamily: Strings.fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      leading: Icon(
                                        Icons.child_friendly,
                                        color: Color(0xFFD9D9D9),
                                      ),
                                      title: Text(
                                        'Has children',
                                        style: TextStyle(
                                          color: Color(0xFF7F87A6),
                                          fontSize: 14,
                                          fontFamily: Strings.fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    ListTile(
                                      leading: Icon(
                                        Icons.pets,
                                        color: Color(0xFFD9D9D9),
                                      ),
                                      title: Text(
                                        'Dog',
                                        style: TextStyle(
                                          color: Color(0xFF7F87A6),
                                          fontSize: 14,
                                          fontFamily: Strings.fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              CardGradientPicture(
                                width: size.width * 0.90,
                                height: size.height * 0.55,
                                image: const DecorationImage(
                                  image: AssetImage('assets/imgs/girl7.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              const Text(
                                'Vision for the future',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF6C2EBC),
                                  fontSize: 20,
                                  fontFamily: Strings.fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              _OverviewProfileCard(
                                size: size,
                                title: 'FINANCIAL HABITS AND GOALS',
                                description:
                                    'Lorem ipsum dolor sit amet consectetur. Aliquet ullamcorper Lorem ipsum dolor sit amet consectetur. Aliquet ullamcorper',
                              ),
                              SizedBox(height: size.height * 0.02),
                              _OverviewProfileCard(
                                size: size,
                                title: 'RELATIONSHIP HISTORY AND VIEWS',
                                description:
                                    'Lorem ipsum dolor sit amet consectetur. Aliquet ullamcorper Lorem ipsum dolor sit amet consectetur. Aliquet ullamcorper',
                              ),
                              SizedBox(height: size.height * 0.1),
                            ],
                          ),
                        ),
                      );
                    },
                    controller: DraggableScrollableController(),
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
            // Container(
            //   padding: const EdgeInsets.all(1.5),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     gradient: AppTheme.linearGradient,
            //   ),
            //   child: Container(
            //     width: size.width * 0.78,
            //     height: size.height * 0.50,
            //     padding: const EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: const Color(0xFFEFF0FB),
            //       image: DecorationImage(
            //         image: imageProvider,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     child:
            //   ),
            // ),

            CardProfile(
              user: user,
              imageProvider: imageProvider,
            ),
            //       Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     Row(
            //       children: [
            //         IconButton(
            //           onPressed: () {},
            //           style: IconButton.styleFrom(
            //             backgroundColor: Colors.white,
            //           ),
            //           icon: const Icon(
            //             Icons.note_add_rounded,
            //             color: Color(0xFFD9D9D9),
            //           ),
            //         )
            //       ],
            //     ),
            //     const Spacer(),
            //     Text(
            //       '${user.name} (24)',
            //       style: const TextStyle(
            //         color: Color(0xFF9CA4BF),
            //         fontSize: 22,
            //         fontFamily: Strings.fontFamily,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     SizedBox(height: size.height * 0.02),
            //     const Text(
            //       'Lives in New York',
            //       style: TextStyle(
            //         color: Color(0xFF9CA4BF),
            //         fontSize: 12,
            //         fontFamily: Strings.fontFamily,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //     SizedBox(height: size.height * 0.02),
            //     FilledButton(
            //       onPressed: () {},
            //       style: FilledButton.styleFrom(
            //         backgroundColor: Colors.white,
            //       ),
            //       child: const Text(
            //         '95% match',
            //         style: TextStyle(
            //           color: Color(0xFF9CA4BF),
            //           fontSize: 12,
            //           fontFamily: Strings.fontFamily,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     )
            //   ],
            // ),

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

class _CardSeeProfileDetails extends StatefulWidget {
  const _CardSeeProfileDetails({this.user});

  final UserEntity? user;

  @override
  State<_CardSeeProfileDetails> createState() => _CardSeeProfileDetailsState();
}

class _CardSeeProfileDetailsState extends State<_CardSeeProfileDetails>
    with TickerProviderStateMixin {
  late TabController _tabControllerReport;
  final notifications = getIt<HandlerNotification>();
  final List<Tab> tabsReport = <Tab>[
    const Tab(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_search_outlined),
          SizedBox(width: 8),
          Text(
            'Report User',
            style: TextStyle(
              color: Color(0xFF9CA4BF),
              fontSize: 16,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    ),
    const Tab(
        icon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.person_off_outlined),
        SizedBox(width: 8),
        Text(
          'User Block',
          style: TextStyle(
            color: Color(0xFF9CA4BF),
            fontSize: 16,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    )),
  ];

  void _handleBlockUser(BuildContext context, {required Size size}) async {
    try {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      await context.read<BlockCubit>().blockedUser(id: widget.user?.id ?? -1);
      if (!mounted) return;
      await notifications.ntsSuccessNotification(
        context,
        message: 'User successfully blocked',
        height: size.height * 0.12,
        width: size.width * 0.90,
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      if (e is NtsErrorResponse) {
        notifications.ntsErrorNotification(
          context,
          message: e.message ?? '',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
      }

      if (e is DioException) {
        notifications.ntsErrorNotification(
          context,
          message: 'Sorry. Something went wrong. Please try again later',
          height: size.height * 0.12,
          width: size.width * 0.90,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabControllerReport =
        TabController(vsync: this, length: tabsReport.length, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      margin: EdgeInsets.zero,
      elevation: 8.0,
      child: Container(
        width: size.width,
        height: size.height * 0.55,
        padding:
            const EdgeInsets.only(top: 20, bottom: 25, left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              widget.user?.avatar,
              errorListener: (p0) =>
                  const AssetImage('assets/imgs/photo_camera_front.png'),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32,
                      )),
                  Text(
                    '${widget.user?.name}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        // showDragHandle: true,
                        // enableDrag: true,
                        useSafeArea: true,
                        isScrollControlled: false,
                        builder: (BuildContext context) {
                          return Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: SafeArea(
                              bottom: false,
                              child: DraggableScrollableSheet(
                                initialChildSize: 1.0,
                                // minChildSize: 0.8,
                                maxChildSize: 1.0,
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  return SizedBox(
                                    height: size.height * 0.80,
                                    width: size.width * 0.95,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20.0),
                                        SizedBox(
                                          height: size.height * 0.05,
                                          width: size.width,
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 15,
                                            ),
                                            leading: const CircleAvatarProfile(
                                              image: 'assets/imgs/girl1.png',
                                            ),
                                            title: const Text(
                                              'Melissandre (31)',
                                              style: TextStyle(
                                                color: Color(0xFF261638),
                                                fontSize: 20,
                                                fontFamily: Strings.fontFamily,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              icon: const Icon(
                                                Icons.cancel_outlined,
                                                color: AppTheme.disabledColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 25.0),
                                        TabBar(
                                          controller: _tabControllerReport,
                                          tabs: tabsReport,
                                        ),
                                        Expanded(
                                          child: TabBarView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            controller: _tabControllerReport,
                                            children: [
                                              _ReportUserPage(size: size),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                child: ListView(
                                                  children: [
                                                    const Text(
                                                      'ARE YOU SURE YOU WANT TO BLOCK THIS MELISSANDRE?',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF686E8C),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            Strings.fontFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Your Blocked list will be on your profile settings',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF9CA4BF),
                                                        fontSize: 12,
                                                        fontFamily:
                                                            Strings.fontFamily,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            size.height * 0.15),
                                                    ButtonBar(
                                                      alignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.40,
                                                          child: FilledButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(),
                                                            style: FilledButton
                                                                .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 30,
                                                                vertical: 10,
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'NO',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontFamily: Strings
                                                                    .fontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.40,
                                                          child: FilledButton(
                                                            onPressed: () {},
                                                            // =>
                                                            //     _handleBlockUser(
                                                            //   context,
                                                            //   size: size,
                                                            // ),
                                                            style: FilledButton
                                                                .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 30,
                                                                vertical: 10,
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'YES',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontFamily: Strings
                                                                    .fontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                controller: DraggableScrollableController(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.no_accounts_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6000000238418579),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '95% match',
                    style: TextStyle(
                      color: Color.fromARGB(255, 231, 77, 16),
                      fontSize: 12,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
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

class _SmallDescriptionProfile extends StatelessWidget {
  const _SmallDescriptionProfile({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      margin: EdgeInsets.zero,
      child: Container(
        width: size.width * 0.95,
        height: size.height * 0.28,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: const Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.person_outlined,
                color: AppTheme.disabledColor,
              ),
              title: Text(
                'Female / Lesbian',
                style: TextStyle(
                  color: Color(0xFF7F87A6),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                color: AppTheme.disabledColor,
              ),
              title: Text(
                'Lives in New York / 15 min away',
                style: TextStyle(
                  color: Color(0xFF7F87A6),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.panorama_fish_eye_sharp,
                color: AppTheme.disabledColor,
              ),
              title: Text(
                'Female / Lesbian',
                style: TextStyle(
                  color: Color(0xFF7F87A6),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HobbiesProfile extends StatelessWidget {
  const _HobbiesProfile({
    required this.size,
    required List<String> hobbies,
  }) : _hobbies = hobbies;

  final Size size;
  final List<String> _hobbies;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: size.width * 0.95,
        height: size.height * 0.30,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'HOBBIES',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Expanded(
                child: GridView.builder(
              itemCount: _hobbies.length,
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.5 / 1,
                crossAxisCount: 3, // number of items in each row
                mainAxisSpacing: 0.5, // spacing between rows
                crossAxisSpacing: 0.1, // spacing between columns
              ),
              itemBuilder: (context, index) {
                return ActionChip(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  label: Text(_hobbies[index]),
                );
              },
            )
                // ButtonBar(
                //   children: [
                //     ActionChip(
                //       // avatar: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                //       label: const Text(
                //           'Save to favorites'),
                //       onPressed: () => {},
                //     ),
                //     ActionChip(
                //       // avatar: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                //       label: const Text('Save to pepe'),
                //       onPressed: () => {},
                //     ),
                //     ActionChip(
                //       // avatar: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                //       label: const Text(
                //           'Save to favorites'),
                //       onPressed: () => {},
                //     ),
                //     ActionChip(
                //       // avatar: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                //       label: const Text(
                //           'Save to favorites'),
                //       onPressed: () => {},
                //     ),
                //     ActionChip(
                //       // avatar: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                //       label: const Text(
                //           'Save to favorites'),
                //       onPressed: () => {},
                //     ),
                //     ActionChip(
                //       // avatar: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                //       label: const Text(
                //           'Save to favorites'),
                //       onPressed: () => {},
                //     ),
                //   ],
                // ),

                )
          ],
        ),
      ),
    );
  }
}

class _OthersPicturesProfile extends StatelessWidget {
  const _OthersPicturesProfile({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CardGradientPicture(
          image: const DecorationImage(
            image: AssetImage('assets/imgs/girl8.png'),
            fit: BoxFit.cover,
          ),
          width: size.width * 0.45,
          height: size.height * 0.35,
        ),
        CardGradientPicture(
          image: const DecorationImage(
            image: AssetImage('assets/imgs/girl9.png'),
            fit: BoxFit.cover,
          ),
          width: size.width * 0.45,
          height: size.height * 0.35,
        ),
      ],
    );
  }
}

class _PersonalQuestionInfo extends StatelessWidget {
  const _PersonalQuestionInfo({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5.0,
      margin: EdgeInsets.zero,
      child: Container(
        width: size.width * 0.95,
        height: size.height * 0.48,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: const Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.liquor_outlined,
                color: AppTheme.disabledColor,
              ),
              title: Text(
                'Short Term relationship',
                style: TextStyle(
                  color: Color(0xFF7F87A6),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.import_contacts_outlined,
                color: AppTheme.disabledColor,
              ),
              title: Text(
                'Agnostic',
                style: TextStyle(
                  color: Color(0xFF7F87A6),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.masks,
                color: AppTheme.disabledColor,
              ),
              title: Text(
                'SDM',
                style: TextStyle(
                  color: Color(0xFF7F87A6),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.diversity_1_outlined,
                color: AppTheme.disabledColor,
              ),
              title: Text(
                'Monogamy',
                style: TextStyle(
                  color: Color(0xFF7F87A6),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.bed,
                color: AppTheme.disabledColor,
              ),
              title: Text(
                'Bottom',
                style: TextStyle(
                  color: Color(0xFF7F87A6),
                  fontSize: 14,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
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

class _ReportUserPage extends StatelessWidget {
  const _ReportUserPage({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _TitleReportUser(size: size),
        _CardReportUser(size: size),
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: size.width * 0.20, vertical: 15),
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            ),
            child: const Text(
              'SEND REPORT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TitleReportUser extends StatelessWidget {
  const _TitleReportUser({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.95,
      height: size.height * 0.10,
      child: const ListTile(
        title: Text(
          'PLEASE, SELECT A REASON',
          style: TextStyle(
            color: Color(0xFF686E8C),
            fontSize: 14,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Your report is private',
          style: TextStyle(
            color: Color(0xFF9CA4BF),
            fontSize: 12,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _CardReportUser extends StatelessWidget {
  const _CardReportUser({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF0FB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _RadioReportReason(
            value: 1,
            groupValue: 1,
            title: 'I\'m not interested in this person',
            onChanged: (value) {},
          ),
          const Divider(),
          _RadioReportReason(
            value: 2,
            groupValue: 1,
            title: 'Offensive or abusive',
            onChanged: (value) {},
          ),
          const Divider(),
          _RadioReportReason(
            value: 3,
            groupValue: 1,
            title: 'Underage',
            onChanged: (value) {},
          ),
          const Divider(),
          _RadioReportReason(
            value: 4,
            groupValue: 1,
            title: 'Fake profile',
            onChanged: (value) {},
          ),
          const Divider(),
          _RadioReportReason(
            value: 5,
            groupValue: 1,
            title: 'Inappropiate photos or behavior',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class _RadioReportReason extends StatelessWidget {
  const _RadioReportReason({
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
  });

  final Object value;
  final Object groupValue;
  final String title;
  final ValueChanged<Object?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      value: true,
      groupValue: 1,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF686E8C),
          fontSize: 14,
          fontFamily: Strings.fontFamily,
          // fontWeight: FontWeight.w600,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
