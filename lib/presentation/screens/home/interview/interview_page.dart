import 'package:ai_date/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart' show AppTheme, Strings;

class InterViewPage extends StatelessWidget {
  const InterViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/imgs/aidate_home.png', height: 30),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Interview',
                style: TextStyle(
                  color: Color(0xFF261638),
                  fontSize: 28,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w700,
                ),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
                label: const Text('Skip'),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              'Unlock your perfect match! Complete all 3 interviews and let AI find your ideal date today!',
              style: TextStyle(
                color: Color(0xFF7F87A6),
                fontSize: 16,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _CardInterview(
                  size: size,
                  icon: const Icon(
                    Icons.diversity_2,
                    color: Colors.purple,
                    size: 32,
                  ),
                  titleHeader: 'Personal Life',
                  title: 'What makes you, you',
                  isAlreadyUsed: false,
                  percent: 25,
                ),
                SizedBox(height: size.height * 0.02),
                _CardInterview(
                  size: size,
                  icon: const Icon(
                    Icons.real_estate_agent,
                    color: Colors.deepPurple,
                    size: 32,
                  ),
                  titleHeader: 'Relationship Preferences',
                  title: 'Your Ideal Match',
                  isAlreadyUsed: false,
                  percent: 0.0,
                ),
                SizedBox(height: size.height * 0.02),
                _CardInterview(
                  size: size,
                  icon: const Icon(
                    Icons.supervised_user_circle,
                    color: Colors.purple,
                    size: 32,
                  ),
                  titleHeader: 'Friends, Family, and Hobbies',
                  title: 'Your Circle',
                  isAlreadyUsed: false,
                  percent: 100.0,
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CardInterview extends StatelessWidget {
  const _CardInterview({
    required this.size,
    required this.titleHeader,
    required this.title,
    required this.icon,
    this.onTap,
    required this.isAlreadyUsed,
    this.percent = 0.0,
  });

  final Size size;
  final String titleHeader;
  final String title;
  final Widget icon;
  final GestureTapCallback? onTap;
  final bool isAlreadyUsed;
  final double percent;

  @override
  Widget build(BuildContext context) {
    if (isAlreadyUsed) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(InterviewChatScreen.routeName);
        },
        child: Container(
          height: size.height * 0.25,
          width: size.width * 0.90,
          decoration: BoxDecoration(
            gradient: AppTheme.linearGradientReverse,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0x336C2EBC),
                  ),
                  child: Center(
                    child: icon,
                  ),
                ),
                title: Text(
                  titleHeader,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              percent == 0
                  ? InkWell(
                      onTap: onTap,
                      child: Container(
                        width: 170,
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: const BoxDecoration(
                          gradient: AppTheme.linearGradient,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'START HERE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: Strings.fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  : percent == 100.0
                      ? FilledButton(
                          onPressed: () {},
                          child: const Text('Complete'),
                        )
                      : Row(
                          children: [
                            Container(
                              width: size.width * 0.70,
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 15.0),
                              child: Center(
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.white
                                      .withOpacity(0.30000001192092896),
                                  borderRadius: BorderRadius.circular(20),
                                  minHeight: 8,
                                  value: 0.25,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.15,
                              height: size.height * 0.04,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: ShapeDecoration(
                                color: Colors.white
                                    .withOpacity(0.30000001192092896),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '25%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: Strings.fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
              percent != 0.0
                  ? SizedBox(height: size.height * 0.01)
                  : Container()
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(InterviewChatScreen.routeName);
        },
        child: Container(
          height: size.height * 0.25,
          width: size.width * 0.90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
              color: const Color(0xFF5005B0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0x336C2EBC),
                  ),
                  child: Center(
                    child: icon,
                  ),
                ),
                title: Text(
                  titleHeader,
                  style: const TextStyle(
                    color: Color(0xFF7F87A6),
                    fontSize: 12,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF6C2EBC),
                    fontSize: 24,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  width: 170,
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    gradient: AppTheme.linearGradient,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'START HERE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
