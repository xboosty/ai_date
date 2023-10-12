import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:appinio_swiper/appinio_swiper.dart'
    show AppinioSwiper, AppinioSwiperDirection;

import '../../../../config/config.dart' show AppTheme, Strings;
import '../../screens.dart' show ChangePasswordScreen, SignInScreen;
import '../../../widgets/widgets.dart'
    show
        CircularOutlineGradientButton,
        ConfigurationInputField,
        CustomDropdownButton,
        DatePickerFormField,
        FilledColorizedButton,
        ProfilePicturePhoto;

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required TabController tabController,
    required this.tabs,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const _AppBarAIDate(),
          SizedBox(height: size.height * 0.02),
          const _ProfileToggle(),
          SizedBox(height: size.height * 0.02),
          TabBar(
            controller: _tabController,
            tabs: tabs,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const _ProfileEditPage(),
                const _UserCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarAIDate extends StatelessWidget {
  const _AppBarAIDate();

  Future<void> _logOut(BuildContext context) async {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideInRight(child: child);
          },
        ),
        (route) => false);

    // try {
    //     await context.read<AccountCubit>();

    //     Navigator.of(context).pushAndRemoveUntil(
    //     PageRouteBuilder(
    //       pageBuilder: (context, animation, secondaryAnimation) =>
    //           const SignInScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return SlideInRight(child: child);
    //       },
    //     ),
    //     (route) => false);
    //   } catch (e) {
    //     print('Esto es un error: ${e.toString()}');
    //     if (!mounted) return;
    //     ElegantNotification.error(
    //       notificationPosition: NotificationPosition.bottomCenter,
    //       animation: AnimationType.fromBottom,
    //       background: Colors.red.shade100,
    //       showProgressIndicator: true,
    //       title: const Text(
    //         "Error try again",
    //         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    //       ),
    //       description: const Text(
    //         "Something happend!",
    //         style: TextStyle(
    //           color: Colors.black,
    //         ),
    //       ),
    //     ).show(context);
    //   }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/imgs/aidate_home.png'),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              enableDrag: true,
              useSafeArea: true,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                  initialChildSize: 1.0,
                  minChildSize: 1.0,
                  maxChildSize: 1.0,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          const Text(
                            'Settings',
                            style: TextStyle(
                              color: Color(0xFF261638),
                              fontSize: 20,
                              fontFamily: Strings.fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          _AccountSettings(size: size),
                          _PrivacyAndSecuritySetting(size: size),
                          _LocationSetting(size: size),
                          _NotificationsSetting(size: size),
                          _LegalSetting(size: size),
                          _HelpSupportSetting(size: size),
                          SizedBox(height: size.height * 0.02),
                          Center(
                            child: Image.asset('assets/imgs/aidate-logo.png'),
                          ),
                          SizedBox(height: size.height * 0.05),
                          SizedBox(
                            width: size.width * 0.90,
                            child: FilledButton.icon(
                              onPressed: () {
                                // Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                    icon: const Icon(
                                      Icons.info_outline_rounded,
                                      size: 40,
                                    ),
                                    title: const Text('Exit AI Date'),
                                    content: const Text(
                                        'Are you sure you want to exit the app?'),
                                    actions: [
                                      FilledButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Cancel'),
                                      ),
                                      FilledButton(
                                        onPressed: () => _logOut(context),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.login,
                                color: Color(0xFF6C2EBC),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF6C2EBC),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                              ),
                              label: const Text(
                                'LOG OUT',
                                style: TextStyle(
                                  color: Color(0xFF6C2EBC),
                                  fontSize: 16,
                                  fontFamily: Strings.fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          SizedBox(
                            width: size.width * 0.90,
                            child: FilledButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete_forever_outlined,
                                color: Color(0xFF6C2EBC),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF6C2EBC),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                              ),
                              label: const Text(
                                'DELETE ACCOUNT',
                                style: TextStyle(
                                  color: Color(0xFF6C2EBC),
                                  fontSize: 16,
                                  fontFamily: Strings.fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                        ],
                      ),
                    );
                  },
                  controller: DraggableScrollableController(),
                );
              },
            );
          },
          icon: const Icon(
            Icons.settings,
            size: 32,
            color: Color(0xFFD9D9D9),
          ),
        )
      ],
    );
  }
}

class _ProfileToggle extends StatefulWidget {
  const _ProfileToggle();

  @override
  State<_ProfileToggle> createState() => _ProfileToggleState();
}

class _ProfileToggleState extends State<_ProfileToggle> {
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 28,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        ToggleSwitch(
          minWidth: 75.0,
          cornerRadius: 20.0,
          activeBgColors: [
            const [Color(0xFF00E492)],
            [Colors.red.shade300]
          ],
          activeFgColor: Colors.white,
          inactiveBgColor: const Color(0xFFEFF0FC),
          inactiveFgColor: const Color(0xFF7F88A7),
          customTextStyles: const [
            TextStyle(
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
            TextStyle(
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ],
          initialLabelIndex: indexSelected,
          totalSwitches: 2,
          labels: const ['Online', 'Offline'],
          radiusStyle: true,
          onToggle: (index) {
            print('switched to: $index');
            setState(() {
              indexSelected = index ?? 1;
            });
          },
        ),
      ],
    );
  }
}

class _ProfileEditPage extends StatefulWidget {
  const _ProfileEditPage();

  @override
  State<_ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<_ProfileEditPage> {
  final _dateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView(
      children: [
        _CardPersonalInfo(size: size, dateCtrl: _dateCtrl),
        _CardGenderInfo(size: size),
        const ListTile(
          leading: Icon(Icons.add_photo_alternate, size: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
          title: Text(
            'PROFILE PICTURES',
            style: TextStyle(
              color: Color(0xFF261638),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Users who have uploaded 2 or more pictures have a higher likelihood of finding matches.',
            style: TextStyle(
              color: Color(0xFF9CA4BF),
              fontSize: 12,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfilePicturePhoto(
                    width: size.width * 0.50,
                    height: size.height * 0.31,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfilePicturePhoto(
                          width: size.width * 0.25, height: size.height * 0.15),
                      const SizedBox(height: 5.0),
                      ProfilePicturePhoto(
                          width: size.width * 0.25, height: size.height * 0.15),
                    ],
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfilePicturePhoto(
                      width: size.width * 0.25, height: size.height * 0.15),
                  ProfilePicturePhoto(
                      width: size.width * 0.25, height: size.height * 0.15),
                  ProfilePicturePhoto(
                      width: size.width * 0.25, height: size.height * 0.15),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              FilledColorizedButton(
                width: size.width,
                height: 50,
                title: 'SAVE CHANGES',
                isTrailingIcon: false,
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardGenderInfo extends StatelessWidget {
  const _CardGenderInfo({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size.width * 0.90,
        height: size.height * 0.33,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF0FB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),
            CustomDropdownButton(
              hintText: const Text('Gender'),
              listValues: ['Non-Binary', 'Women', 'Men'],
              dropdownValue: 'Non-Binary',
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: size.height * 0.03),
            CustomDropdownButton(
              hintText: const Text('Sexual Orientation'),
              listValues: ['Straight', 'Gay', 'Bisexual'],
              dropdownValue: 'Straight',
              onChanged: (value) {
                print(value);
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Show my gender in my profile',
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 12,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: false,
              onChanged: (value) => {},
            )
          ],
        ),
      ),
    );
  }
}

class _CardPersonalInfo extends StatelessWidget {
  const _CardPersonalInfo({
    required this.size,
    required TextEditingController dateCtrl,
  }) : _dateCtrl = dateCtrl;

  final Size size;
  final TextEditingController _dateCtrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size.width * 0.90,
        height: size.height * 0.42,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF0FB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ConfigurationInputField(
              fontSize: 10,
              labelText: 'Name',
              colorLabel: Color(0xFF6C2EBC),
            ),
            const ConfigurationInputField(
              fontSize: 10,
              labelText: 'Last Name',
              colorLabel: Color(0xFF6C2EBC),
            ),
            const ConfigurationInputField(
              fontSize: 10,
              labelText: 'Email',
              colorLabel: Color(0xFF6C2EBC),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: size.height * 0.01),
            DatePickerFormField(
              labelText: 'Date of birth',
              controller: _dateCtrl,
              onDateSelected: (p0) => {},
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpSupportSetting extends StatelessWidget {
  const _HelpSupportSetting({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.receipt_long),
          title: Text(
            'HELP AND SUPPORT',
            style: TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: size.width * 0.90,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Contact us',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'FAQ',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Follow us',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Give us feedback',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Rate us',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'App Version',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const SizedBox(
                  width: 61,
                  child: Row(
                    children: [
                      Text(
                        'V1.03',
                        style: TextStyle(
                          color: Color(0xFFCCC1EA),
                          fontSize: 12,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15.0,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegalSetting extends StatelessWidget {
  const _LegalSetting({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.receipt_long),
          title: Text(
            'LEGAL',
            style: TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: size.width * 0.90,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Terms of use',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Cookie Policy',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Community Rules',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotificationsSetting extends StatelessWidget {
  const _NotificationsSetting({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text(
            'NOTIFICATIONS',
            style: TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: size.width * 0.90,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Push notifications',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'In-app notifications',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Email',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LocationSetting extends StatelessWidget {
  const _LocationSetting({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.person_pin_circle),
          title: Text(
            'LOCATION',
            style: TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: size.width * 0.90,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text(
                  'Allow app use my location',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: true,
                onChanged: (value) {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'My location',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const SizedBox(
                  width: 121,
                  child: Row(
                    children: [
                      Text(
                        'New York, USA',
                        style: TextStyle(
                          color: Color(0xFFCCC1EA),
                          fontSize: 12,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15.0,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              const Divider(),
              SwitchListTile(
                title: const Text(
                  'Only people near me',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Bloqued list',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _PrivacyAndSecuritySetting extends StatelessWidget {
  const _PrivacyAndSecuritySetting({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        const ListTile(
          leading: Icon(Icons.privacy_tip),
          title: Text(
            'PRIVACY AND SECURITY',
            style: TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: size.width * 0.90,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Sign-in methods',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ChangePasswordScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideInRight(
                        child: child,
                      );
                    },
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _AccountSettings extends StatelessWidget {
  const _AccountSettings({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.person_pin),
          title: Text(
            'ACCOUNT',
            style: TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: size.width * 0.90,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text(
                  'Pause Account',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Pausing prevents your profile from being shown to new people',
                  style: TextStyle(
                    color: Color(0xFFBDC0D6),
                    fontSize: 12,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              const Divider(),
              SwitchListTile(
                title: const Text(
                  'Active Dark Mode',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Profile Control',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Bloqued list',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.height * 0.75,
        child: AppinioSwiper(
          cardsCount: 10,
          cardsSpacing: 0.0,
          onSwiping: (AppinioSwiperDirection direction) {
            print(direction.toString());
          },
          cardsBuilder: (BuildContext context, int index) {
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
                        image: const DecorationImage(
                          image:
                              AssetImage('assets/imgs/photo_camera_front.png'),
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
                          const Text(
                            'Jennifer (24)',
                            style: TextStyle(
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
                        const CircularOutlineGradientButton(
                          width: 56.0,
                          height: 56.0,
                          child: Icon(
                            Icons.close,
                            color: Color.fromARGB(255, 209, 70, 15),
                            size: 32,
                          ),
                        ),
                        SizedBox(width: size.width * 0.30),
                        CircularGradientButton(
                          heroTag: 'Like',
                          child: const Icon(Icons.favorite, size: 32),
                          callback: () {},
                          gradient: AppTheme.linearGradientReverse,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
