import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../widgets/widgets.dart'
    show CustomDropdownButton, DatePickerFormField;
import '../screens.dart' show SignInScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedPage = 0;

  List<BottomNavigationBarItem> _itemsButtonBar = const [
    BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(
        Icons.contacts,
        size: 32,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Interview',
      icon: Icon(
        Icons.receipt_long,
        size: 32,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Premium',
      icon: Icon(
        Icons.diamond,
        size: 32,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Discover',
      icon: Icon(
        Icons.swipe_right,
        size: 32,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Chat',
      icon: Icon(
        Icons.message,
        size: 32,
      ),
    ),
  ];

  static const List<Tab> tabs = <Tab>[
    Tab(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit_square),
          SizedBox(width: 8),
          Text(
            'Edit',
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
    Tab(
        icon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.person_pin),
        SizedBox(width: 8),
        Text(
          'Preview',
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
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedPage,
          children: [
            _ProfilePage(size: size, tabController: _tabController, tabs: tabs),
            const Center(
              child: Text('Interview'),
            ),
            const Center(
              child: Text('Premium'),
            ),
            const Center(
              child: Text('Discover'),
            ),
            const Center(
              child: Text('Chat'),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (index) {
            setState(() {
              _selectedPage = index;
            });
          },
          elevation: 18.0,
          selectedItemColor: AppTheme.secondaryColor,
          selectedLabelStyle: const TextStyle(
            color: Color(0xFF261638),
            fontSize: 11,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          unselectedItemColor: AppTheme.disabledColor,
          items: _itemsButtonBar,
        ),
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({
    super.key,
    required this.size,
    required TabController tabController,
    required this.tabs,
  }) : _tabController = tabController;

  final Size size;
  final TabController _tabController;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
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
              children: const [
                _ProfileEditPage(),
                Icon(Icons.directions_transit),
              ],
            ),
          ),
        ],
      ),
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
        Row(
          children: [
            Container(
              width: size.width * 0.50,
              height: size.height * 0.30,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF0FB),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: DottedBorder(
                  color: Color(0xFF9CA4BF),
                  strokeWidth: 3,
                  child: Column(),
                ),
              ),
            ),
          ],
        )
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
              labelText: 'Name',
            ),
            const ConfigurationInputField(
              labelText: 'Last Name',
            ),
            const ConfigurationInputField(
              labelText: 'Email',
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

class ConfigurationInputField extends StatelessWidget {
  const ConfigurationInputField({
    super.key,
    required this.labelText,
    this.keyboardType,
  });

  final String labelText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Color(0xFF261638),
        fontSize: 14,
        fontFamily: Strings.fontFamily,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFF6C2EBC),
          fontSize: 10,
          fontFamily: Strings.fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
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

class _AppBarAIDate extends StatelessWidget {
  const _AppBarAIDate();

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
                                        onPressed: () => Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      const SignInScreen(),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    return SlideInRight(
                                                        child: child);
                                                  },
                                                ),
                                                (route) => false),
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
                                foregroundColor: Color(0xFF6C2EBC),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                              ),
                              label: Text(
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
                              icon: Icon(
                                Icons.delete_forever_outlined,
                                color: Color(0xFF6C2EBC),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xFF6C2EBC),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                              ),
                              label: Text(
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
                title: Text(
                  'My location',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: SizedBox(
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
                title: Text(
                  'Bloqued list',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
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
                onTap: () {},
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
                title: Text(
                  'Profile Control',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: Text(
                  'Bloqued list',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
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
