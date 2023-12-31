import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, SharedPref, Strings;
import '../../widgets/widgets.dart' show OutlineText;
import '../screens.dart' show InterViewPage, IntroInterviewPage, ProfilePage;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedPage = 0;

  final List<BottomNavigationBarItem> _itemsButtonBar = const [
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

  bool showFirstInterviewPage = false;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: tabs.length, initialIndex: 1);
    showFirstInterviewPage = SharedPref.pref.showFirstInterviewPage;
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
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _selectedPage,
            children: [
              ProfilePage(tabController: _tabController, tabs: tabs),
              showFirstInterviewPage ? IntroInterviewPage() : InterViewPage(),
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
        ),
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
    );
  }
}
