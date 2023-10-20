import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, Strings;

class InterviewChatScreen extends StatelessWidget {
  const InterviewChatScreen({super.key});

  static const String routeName = '/interview_chat';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Interview 1',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 20,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  // height: 100,
                  // width: 50,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    value: 0.25,
                  ),
                ),
                const Text(
                  '25%',
                  style: TextStyle(
                    color: Color(0xFF6C2EBC),
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
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.80,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                      child: Text(
                        'Great, let\'s start with some questions about you and what makes you unique. These questions will cover your background, values, and what shapes your world. Please take your time and answer as honestly as possible.',
                        style: TextStyle(
                          color: Color(0xFF6C2EBC),
                          fontSize: 20,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide.none,
                      ),
                      side: BorderSide.none,
                      backgroundColor: const Color(0xFFCCC1EA),
                      label: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            color: Color(0xFF261638),
                            fontSize: 12,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    _ChatAI(size: size),
                    _ChatUser(size: size),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Write or Tap and hold to send an audio',
                      style: TextStyle(
                        color: Color(0xFFBDC0D6),
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0.12,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.mic))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ChatUser extends StatelessWidget {
  const _ChatUser({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: size.width * 0.89,
                decoration: BoxDecoration(
                  color: Colors.purple.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: const Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Could you share a story from your life that you think shaped who you are today?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '01:45',
                style: TextStyle(
                  color: Color(0xFFBDC0D6),
                  fontSize: 12,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _ChatAI extends StatelessWidget {
  const _ChatAI({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.89,
                decoration: const BoxDecoration(
                  gradient: AppTheme.linearGradientTopRightBottomLeft,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        backgroundImage:
                            AssetImage('assets/imgs/ai_avatar.png'),
                      ),
                      title: Text(
                        'Could you share a story from your life that you think shaped who you are today?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: Row(
            children: [
              Text(
                '01:45',
                style: TextStyle(
                  color: Color(0xFFBDC0D6),
                  fontSize: 12,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
