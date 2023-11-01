import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart' show AppTheme, Strings;
import '../../../widgets/button_bar/provider/user_chat_provider.dart';
import '../../../widgets/button_bar/provider/user_state.dart';
import '../../../widgets/widgets.dart' show UsersButtonBar;
import 'chat_search_page.dart';

class ChatNewPage extends StatelessWidget {
  ChatNewPage({super.key});

  List<UserState> users = [
    UserState(
      name: 'Olga',
      isConnected: false,
    ),
    UserState(
      name: 'Bia',
      isConnected: false,
    ),
    UserState(
      name: 'Nikey',
      isConnected: false,
    ),
    UserState(
      name: 'Alex',
      isConnected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 28,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        // actions: [ChatSearchPage()],
      ),
      body: ChangeNotifierProvider(
        create: (_) => ButtonCardProvider(users: users),
        child: Column(
          children: [
            _TitleChat(size: size),
            const UsersButtonBar(),
            SizedBox(height: size.height * 0.02),
            _CardChat(size: size),
          ],
        ),
      ),
    );
  }
}

class _CardChat extends StatelessWidget {
  const _CardChat({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final userSelected = context.watch<ButtonCardProvider>().userSelected;

    if (userSelected?.isSelected ?? false) {
      return Expanded(
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 0.85,
            height: size.height * 0.85,
            decoration: BoxDecoration(
              gradient: AppTheme.linearGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              margin: const EdgeInsets.all(2.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Text(
                    'You and Eleanor had match!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF261638),
                      fontSize: 18,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imgs/card_match.png',
                height: size.height * 0.28,
              ),
              const Text(
                'Choose a contact to begin a conversation and discover your ideal Match',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 20,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class _TitleChat extends StatelessWidget {
  const _TitleChat({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.05,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Icon(Icons.favorite_outline_rounded),
          SizedBox(width: size.width * 0.01),
          const Text(
            'YOUR MATCHES',
            style: TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
