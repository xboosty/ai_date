import 'package:flutter/material.dart';

import '../../../../config/config.dart' show SharedPref, Strings;
import '../../../widgets/widgets.dart' show FilledColorizedButton, OutlineText;
import 'interview_page.dart';

class IntroInterviewPage extends StatefulWidget {
  const IntroInterviewPage({super.key});

  @override
  State<IntroInterviewPage> createState() => _IntroInterviewPageState();
}

class _IntroInterviewPageState extends State<IntroInterviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isIntro = SharedPref.pref.showFirstInterviewPage;
    if (isIntro) {
      return SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6000000238418579),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/imgs/heart_interview.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 15.0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              SharedPref.pref.showFirstInterviewPage = false;
                            });
                          },
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const OutlineText(
                    title: 'Welcome to the interview!',
                    color: Colors.white,
                    fontSize: 60,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    child: Text(
                      'Before we begin, it\'s important to understand that finding a true match goes beyond superficial traits; it\'s a journey that requires honesty, self-awareness, and sometimes, vulnerability. Our process is thorough and may seem extensive, but this is to ensure the most accurate results. We\'ll dive deep into various aspects of your personality, preferences, and life goals. Remember, the key to finding a genuine connection is being open and honest. All your responses are encrypted and securely stored, with access granted only at your discretion.',
                      style: TextStyle(
                        color: Color(0xFF6C2EBC),
                        fontSize: 14,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width / 5),
                    child: FilledColorizedButton(
                      width: 165,
                      height: 50,
                      title: 'LET\'S START',
                      isTrailingIcon: true,
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          SharedPref.pref.showFirstInterviewPage = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const InterViewPage();
    }
  }
}
