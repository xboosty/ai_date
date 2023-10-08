import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../config/config.dart' show AppTheme, Strings;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
    )),
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
        body: Container(
          width: double.infinity,
          height: size.height,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppBarAIDate(),
              SizedBox(height: size.height * 0.02),
              ProfileToggle(),
              SizedBox(height: size.height * 0.02),
              TabBar(
                controller: _tabController,
                tabs: tabs,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 18.0,
            selectedItemColor: AppTheme.secondaryColor,
            selectedLabelStyle: const TextStyle(
              color: Color(0xFF261638),
              fontSize: 11,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
            unselectedItemColor: AppTheme.disabledColor,
            items: const [
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
            ]),
        // bottomSheet: BottomSheet(
        //   onClosing: () => {},
        //   builder: (context) => Container(),
        // ),
      ),
    );
  }
}

class ProfileToggle extends StatefulWidget {
  const ProfileToggle({
    super.key,
  });

  @override
  State<ProfileToggle> createState() => _ProfileToggleState();
}

class _ProfileToggleState extends State<ProfileToggle> {
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

class AppBarAIDate extends StatelessWidget {
  const AppBarAIDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/imgs/aidate_home.png'),
        IconButton(
          onPressed: () {
            // showModalBottomSheet(
            //   context: context,
            //   showDragHandle: true,
            //   enableDrag: true,
            //   useSafeArea: true,
            //   isScrollControlled: true,
            //   builder: (BuildContext context) {
            //     return DraggableScrollableSheet(
            //       builder: (BuildContext context,
            //               ScrollController scrollController) =>
            //           Container(
            //         width: size.width * 0.80,
            //         height: size.height * 0.80,
            //         color: Colors.blue,
            //         child: ListView.builder(
            //           controller: scrollController,
            //           itemBuilder: (BuildContext context, int index) =>
            //               Container(
            //             width: size.width * 0.80,
            //             color: Colors.red,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
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
