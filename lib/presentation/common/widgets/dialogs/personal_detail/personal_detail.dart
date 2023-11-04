import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';

import '../../../../../config/config.dart'
    show
        AppTheme,
        BlockCubit,
        BlockState,
        BlockedUsersLoading,
        HandlerNotification,
        NtsErrorResponse,
        Strings,
        getIt;
import '../../../../../domain/domain.dart' show UserEntity;
import '../../widgets.dart'
    show
        ButtonsInfoProfile,
        CardGradientPicture,
        CardInfoProfile,
        CircleAvatarProfile,
        ShadowCardDetail;
import 'info_detail_header_card.dart';

class PersonalDetail extends StatelessWidget {
  const PersonalDetail({super.key, required this.user, required this.hobbies});

  final UserEntity user;
  final List<String> hobbies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 1.0,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
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
                  user: user,
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
                _HobbiesProfile(size: size, hobbies: hobbies),
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

  @override
  void initState() {
    super.initState();
    _tabControllerReport =
        TabController(vsync: this, length: tabsReport.length, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      margin: EdgeInsets.zero,
      elevation: 8.0,
      child: CachedNetworkImage(
        imageUrl: widget.user?.avatar,
        imageBuilder: (context, imageProvider) {
          return ImageProfile(
            tabControllerReport: _tabControllerReport,
            tabsReport: tabsReport,
            image: imageProvider,
            user: widget.user,
          );
        },
        errorWidget: (context, url, error) => ImageProfile(
          tabControllerReport: _tabControllerReport,
          tabsReport: tabsReport,
          image: const AssetImage('assets/imgs/no-image.jpg'),
          user: widget.user,
        ),
        placeholder: (context, url) => ImageProfile(
          tabControllerReport: _tabControllerReport,
          tabsReport: tabsReport,
          image: const AssetImage('assets/imgs/no-image.jpg'),
          user: widget.user,
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

class ImageProfile extends StatelessWidget {
  const ImageProfile({
    super.key,
    this.user,
    required this.tabControllerReport,
    required this.tabsReport,
    required this.image,
  });

  final UserEntity? user;
  final TabController tabControllerReport;
  final List<Widget> tabsReport;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
          onError: (exception, stackTrace) =>
              const AssetImage('assets/imgs/no-image.jpg'),
        ),
      ),
      child: Stack(
        children: [
          const ShadowCardDetail(),
          InfoDetailHeaderCard(
            user: user,
            tabControllerReport: tabControllerReport,
            tabsReport: tabsReport,
          ),
        ],
      ),
    );
  }
}
