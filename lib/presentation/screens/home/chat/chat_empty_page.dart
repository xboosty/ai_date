import 'package:ai_date/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart' show AppTheme, Strings;

class ChatEmptyPage extends StatelessWidget {
  const ChatEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 28,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imgs/chat_bubble.png', height: 200),
            const Text(
              'No matches yet',
              style: TextStyle(
                color: Color(0xFF261638),
                fontSize: 20,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Container(
              height: size.height * 0.10,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const ListTile(
                leading: Icon(Icons.favorite_outline_rounded),
                title: Text(
                  'When a Like turns into a connection, you can chat here',
                  style: TextStyle(
                    color: Color.fromARGB(255, 22, 22, 22),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            FilledColorizedButton(
              width: size.width * 0.90,
              height: 50,
              title: 'TRY BOOSTING YOUR PROFILE',
              isTrailingIcon: true,
              icon: const Icon(Icons.loyalty, color: Colors.white),
              gradient: AppTheme.linearGradientReverse,
            ),
          ],
        ),
      ),
    );
  }
}
