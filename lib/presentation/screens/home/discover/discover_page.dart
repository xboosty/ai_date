import 'package:flutter/material.dart';
import '../../../../config/config.dart' show Strings;

import 'like_sent/like_sent_page.dart';
import 'likeme/likeme_page.dart';
import 'mutual_likes/mutual_likes_page.dart';
import 'suggestion/suggestion_page.dart';

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
        icon: Icon(Icons.loyalty_outlined),
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
        // actions: [
        //   const Icon(Icons.tune, color: Colors.grey),
        //   SizedBox(width: size.width * 0.04),
        // ],
        bottom: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          tabs: tabs,
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const <Widget>[
            SuggestionPage(),
            MutualLikesPage(),
            LikeMePage(),
            LikeSentPage(),
          ],
        ),
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
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
