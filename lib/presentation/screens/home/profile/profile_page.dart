import 'dart:convert';

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
        CircleAvatarProfile,
        CircularOutlineGradientButton,
        ConfigurationInputField,
        CustomAlertDialog,
        CustomDropdownButton,
        DatePickerFormField,
        FilledColorizedButton,
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
              children: [
                const _ProfileEditPage(),
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

    return Center(
      child: SizedBox(
        height: size.height * 0.75,
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
      ),
    );
  }
}

class _CardCouple extends StatelessWidget {
  const _CardCouple({
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
                    image: imageProvider,
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
