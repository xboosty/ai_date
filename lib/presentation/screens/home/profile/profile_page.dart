import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

import '../../../../config/config.dart'
    show
        AccountCubit,
        AccountState,
        AppTheme,
        BlockCubit,
        CouplesCubit,
        CouplesData,
        CouplesError,
        CouplesInitial,
        CouplesLoading,
        CouplesState,
        Genders,
        HandlerNotification,
        NtsErrorResponse,
        Sexuality,
        SharedPref,
        Strings,
        UserRegisterStatus,
        getIt;
import '../../../../domain/domain.dart' show UserEntity;
import '../../screens.dart'
    show BloquedListScreen, ChangePasswordScreen, SignInScreen;
import '../../../widgets/widgets.dart'
    show
        ButtonsInfoProfile,
        CardGradientPicture,
        CardInfoProfile,
        CardProfile,
        CircleAvatarProfile,
        CircularOutlineGradientButton,
        ConfigurationInputField,
        CustomAlertDialog,
        CustomDropdownButton,
        DatePickerFormField,
        FilledColorizedButton,
        PickerImage,
        ProfilePicturePhoto;

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required TabController tabController,
    required this.tabs,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<Tab> tabs;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final couplesCubit = getIt<CouplesCubit>();

  @override
  void initState() {
    super.initState();
    couplesCubit.fetchCouplesUsers();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      padding: const EdgeInsets.only(left: 20, right: 20),
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
            controller: widget._tabController,
            tabs: widget.tabs,
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: widget._tabController,
              children: const [
                _ProfileEditPage(),
                _ProfilePreviewPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarAIDate extends StatefulWidget {
  const _AppBarAIDate();

  @override
  State<_AppBarAIDate> createState() => _AppBarAIDateState();
}

class _AppBarAIDateState extends State<_AppBarAIDate> {
  Future<void> _logOut(BuildContext context, {required Size size}) async {
    final notifications = getIt<HandlerNotification>();
    try {
      await context.read<AccountCubit>().logOutUser();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        SignInScreen.routeName,
        (route) => false,
      );
    } catch (e) {
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
          height: size.height * 0.14,
          width: size.width * 0.90,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/imgs/aidate_home.png',
          height: 30,
        ),
        IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
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
                          SizedBox(height: size.height * 0.04),
                          Center(
                            child: Image.asset(
                              'assets/imgs/aidate-logo.png',
                              height: 80,
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          SizedBox(
                            width: size.width * 0.90,
                            child: FilledButton.icon(
                              onPressed: () {
                                // Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) =>
                                      BlocBuilder<AccountCubit, AccountState>(
                                    builder: (context, state) =>
                                        switch (state.status) {
                                      UserRegisterStatus.initial =>
                                        CustomAlertDialog(
                                          title: 'Exit AI Date',
                                          content:
                                              'Are you sure you want to exit the app?',
                                          onPressedCancel: () =>
                                              Navigator.of(context).pop(),
                                          onPressedOk: () =>
                                              _logOut(context, size: size),
                                        ),
                                      UserRegisterStatus.loading =>
                                        const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      UserRegisterStatus.failure =>
                                        CustomAlertDialog(
                                          title: 'Exit AI Date',
                                          content:
                                              'Are you sure you want to exit the app?',
                                          onPressedCancel: () =>
                                              Navigator.of(context).pop(),
                                          onPressedOk: () =>
                                              _logOut(context, size: size),
                                        ),
                                      UserRegisterStatus.success =>
                                        CustomAlertDialog(
                                          title: 'Exit AI Date',
                                          content:
                                              'Are you sure you want to exit the app?',
                                          onPressedCancel: () =>
                                              Navigator.of(context).pop(),
                                          onPressedOk: () =>
                                              _logOut(context, size: size),
                                        ),
                                    },
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
                          SizedBox(height: size.height * 0.05),
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
  final nameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  File? imageUrlSelectedOne;
  File? imageUrlSelectedTwo;
  File? imageUrlSelectedThree;
  File? imageUrlSelectedFour;
  File? imageUrlSelectedFive;
  File? imageUrlSelectedSix;
  UserEntity? user;

  late Genders genderSelected;
  late Sexuality sexualitySelected;
  bool showGenderProfile = false;
  bool showSexualityProfile = false;

  final List<Genders> _genders = [
    Genders(id: 1, name: 'Woman'),
    Genders(id: 0, name: 'Man'),
    Genders(id: 3, name: 'Non Binary'),
  ];

  final List<Sexuality> _sexualities = [
    Sexuality(id: 4, name: 'Prefer not to say'),
    Sexuality(id: 0, name: 'Hetero'),
    Sexuality(id: 1, name: 'Bisexual'),
    Sexuality(id: 2, name: 'Homosexual'),
    Sexuality(id: 3, name: 'Transexual'),
  ];

  void _handleSaveChanges() {}

  @override
  void initState() {
    super.initState();
    try {
      Map<String, dynamic> userMap = jsonDecode(SharedPref.pref.account);
      user = UserEntity.fromJson(userMap);
      nameCtrl.text = user?.name ?? '';
      lastNameCtrl.text = '';
      emailCtrl.text = user?.email ?? '';
      dateCtrl.text = '';
      showGenderProfile = user?.isGenderVisible ?? false;
      showSexualityProfile = user?.isSexualityVisible ?? false;
      switch (user?.genderId) {
        case 0:
          genderSelected = _genders[1];
          break;
        case 1:
          genderSelected = _genders[0];
          break;
        default:
          genderSelected = _genders[2];
      }
    } catch (e) {
      print('Ocurrio un error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView(
      children: [
        _CardPersonalInfo(
          size: size,
          dateCtrl: dateCtrl,
          nameCtrl: nameCtrl,
          lastNameCtrl: lastNameCtrl,
          emailCtrl: emailCtrl,
        ),
        _CardGenderInfo(
          itemsGender: _genders.map<DropdownMenuItem<Genders>>((Genders item) {
            return DropdownMenuItem<Genders>(
              alignment: Alignment.centerLeft,
              value: item,
              child: Text(item.name),
            );
          }).toList(),
          itemsSexuality:
              _sexualities.map<DropdownMenuItem<Sexuality>>((Sexuality item) {
            return DropdownMenuItem<Sexuality>(
              alignment: Alignment.centerLeft,
              value: item,
              child: Text(item.name),
            );
          }).toList(),
          genderSelected: genderSelected,
          sexualitySelected: _sexualities.first,
          showGenderProfile: showGenderProfile,
          showSexualityProfile: showSexualityProfile,
          onChangedGender: (Genders? value) {
            setState(() {
              genderSelected = value ?? _genders[2];
            });
          },
          onChangedSexuality: (Sexuality? value) {},
          onShowGender: (value) {
            setState(() {
              showGenderProfile = value ?? false;
            });
          },
          onShowSexuality: (value) {
            setState(() {
              showSexualityProfile = value ?? false;
            });
          },
        ),
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
                    imageQuality: 100,
                    maxHeight: 720,
                    maxWidth: 480,
                    initialImageUrl: imageUrlSelectedOne,
                    imageUrl: (File? value) {
                      setState(() {
                        imageUrlSelectedOne = value;
                      });
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfilePicturePhoto(
                        width: size.width * 0.25,
                        height: size.height * 0.15,
                        imageQuality: 100,
                        maxHeight: 480,
                        maxWidth: 480,
                        initialImageUrl: imageUrlSelectedTwo,
                        imageUrl: (File? value) {
                          setState(() {
                            imageUrlSelectedTwo = value;
                          });
                        },
                      ),
                      const SizedBox(height: 5.0),
                      ProfilePicturePhoto(
                        width: size.width * 0.25,
                        height: size.height * 0.15,
                        imageQuality: 100,
                        maxHeight: 480,
                        maxWidth: 480,
                        initialImageUrl: imageUrlSelectedThree,
                        imageUrl: (File? value) {
                          setState(() {
                            imageUrlSelectedThree = value;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfilePicturePhoto(
                    width: size.width * 0.25,
                    height: size.height * 0.15,
                    imageQuality: 100,
                    maxHeight: 480,
                    maxWidth: 480,
                    initialImageUrl: imageUrlSelectedFour,
                    imageUrl: (File? value) {
                      setState(() {
                        imageUrlSelectedFour = value;
                      });
                    },
                  ),
                  ProfilePicturePhoto(
                    width: size.width * 0.25,
                    height: size.height * 0.15,
                    imageQuality: 100,
                    maxHeight: 480,
                    maxWidth: 480,
                    initialImageUrl: imageUrlSelectedFive,
                    imageUrl: (File? value) {
                      setState(() {
                        imageUrlSelectedFive = value;
                      });
                    },
                  ),
                  ProfilePicturePhoto(
                    width: size.width * 0.25,
                    height: size.height * 0.15,
                    imageQuality: 100,
                    maxHeight: 480,
                    maxWidth: 480,
                    initialImageUrl: imageUrlSelectedSix,
                    imageUrl: (File? value) {
                      setState(() {
                        imageUrlSelectedSix = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              FilledColorizedButton(
                width: size.width,
                height: 50,
                title: 'SAVE CHANGES',
                isTrailingIcon: false,
                icon: const Icon(
                  Icons.arrow_right_alt,
                  color: Colors.white,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        BlocBuilder<AccountCubit, AccountState>(
                      builder: (context, state) => switch (state.status) {
                        UserRegisterStatus.initial => CustomAlertDialog(
                            title: 'Save Changes',
                            content:
                                'Are you sure you want to save the changes?',
                            onPressedCancel: () => Navigator.of(context).pop(),
                            onPressedOk: () => _handleSaveChanges(),
                          ),
                        UserRegisterStatus.loading => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        UserRegisterStatus.failure => CustomAlertDialog(
                            title: 'Save Changes',
                            content:
                                'Are you sure you want to save the changes?',
                            onPressedCancel: () => Navigator.of(context).pop(),
                            onPressedOk: () => _handleSaveChanges(),
                          ),
                        UserRegisterStatus.success => CustomAlertDialog(
                            title: 'Save Changes',
                            content:
                                'Are you sure you want to save the changes?',
                            onPressedCancel: () => Navigator.of(context).pop(),
                            onPressedOk: () => _handleSaveChanges(),
                          ),
                      },
                    ),
                  );
                },
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
    required this.itemsGender,
    required this.itemsSexuality,
    required this.genderSelected,
    required this.sexualitySelected,
    required this.onChangedGender,
    required this.onChangedSexuality,
    required this.onShowGender,
    required this.onShowSexuality,
    this.showGenderProfile,
    this.showSexualityProfile,
  });

  final Genders genderSelected;
  final Sexuality sexualitySelected;

  final List<DropdownMenuItem<Genders>> itemsGender;
  final List<DropdownMenuItem<Sexuality>> itemsSexuality;
  final ValueChanged<Genders?> onChangedGender;
  final ValueChanged<Sexuality?> onChangedSexuality;
  final bool? showGenderProfile;
  final bool? showSexualityProfile;
  final ValueChanged<bool?> onShowGender;
  final ValueChanged<bool?> onShowSexuality;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.90,
        height: size.height * 0.38,
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
            CustomDropdownButton<Genders>(
              hintText: const Text('Gender'),
              items: itemsGender,
              dropdownValue: genderSelected,
              onChanged: onChangedGender,
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
              value: showGenderProfile,
              onChanged: onShowGender,
            ),
            CustomDropdownButton<Sexuality>(
              hintText: const Text('Sexual Orientation'),
              items: itemsSexuality,
              dropdownValue: sexualitySelected,
              onChanged: onChangedSexuality,
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Show my sexuality in my profile',
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 12,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: showSexualityProfile,
              onChanged: onShowSexuality,
            )
          ],
        ),
      ),
    );
  }
}

class _CardPersonalInfo extends StatefulWidget {
  const _CardPersonalInfo({
    required this.size,
    this.user,
    this.nameCtrl,
    this.lastNameCtrl,
    this.emailCtrl,
    required this.dateCtrl,
  });

  final Size size;
  final TextEditingController dateCtrl;
  final TextEditingController? nameCtrl;
  final TextEditingController? lastNameCtrl;
  final TextEditingController? emailCtrl;
  final UserEntity? user;

  @override
  State<_CardPersonalInfo> createState() => _CardPersonalInfoState();
}

class _CardPersonalInfoState extends State<_CardPersonalInfo> {
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.size.width * 0.90,
        height: widget.size.height * 0.42,
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
            ConfigurationInputField(
              controller: widget.nameCtrl,
              focusNode: _focusNodeFirstName,
              fontSize: 10,
              labelText: 'Name',
              colorLabel: const Color(0xFF6C2EBC),
              textInputAction: TextInputAction.done,
            ),
            ConfigurationInputField(
              controller: widget.lastNameCtrl,
              focusNode: _focusNodeLastName,
              fontSize: 10,
              labelText: 'Last Name',
              colorLabel: const Color(0xFF6C2EBC),
            ),
            ConfigurationInputField(
              controller: widget.emailCtrl,
              focusNode: _focusNodeEmail,
              fontSize: 10,
              labelText: 'Email',
              colorLabel: const Color(0xFF6C2EBC),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: widget.size.height * 0.01),
            DatePickerFormField(
              labelText: 'Date of birth',
              controller: widget.dateCtrl,
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
                title: const Row(
                  children: [
                    Text(
                      'App Version',
                      style: TextStyle(
                        color: Color(0xFF686E8C),
                        fontSize: 14,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'V1.0.1',
                      style: TextStyle(
                        color: Color(0xFFCCC1EA),
                        fontSize: 14,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
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
                onTap: () => Navigator.of(context)
                    .pushNamed(ChangePasswordScreen.routeName),
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
                onTap: () => Navigator.of(context)
                    .pushNamed(BloquedListScreen.routeName),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfilePreviewPage extends StatefulWidget {
  const _ProfilePreviewPage();

  @override
  State<_ProfilePreviewPage> createState() => _ProfilePreviewPageState();
}

class _ProfilePreviewPageState extends State<_ProfilePreviewPage> {
  late UserEntity user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      Map<String, dynamic> userMap = jsonDecode(SharedPref.pref.account);
      user = UserEntity.fromJson(userMap);
    } catch (e) {
      print('Ocurrio un error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CachedNetworkImage(
      imageUrl: user.avatar,
      imageBuilder: (context, imageProvider) => Container(
        width: size.width * 0.80,
        height: size.height,
        alignment: Alignment.center,
        child: CardProfile(
          user: user,
          imageProvider: imageProvider,
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Container(
        width: size.width * 0.80,
        height: size.height,
        alignment: Alignment.center,
        child: Container(
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
          ),
        ),
      ),
    );
  }
}
