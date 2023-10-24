import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../../config/config.dart' show AppTheme, Strings;

class InterviewChatScreen extends StatefulWidget {
  const InterviewChatScreen({super.key});

  static const String routeName = '/interview_chat';

  @override
  State<InterviewChatScreen> createState() => _InterviewChatScreenState();
}

class _InterviewChatScreenState extends State<InterviewChatScreen> {
  String urlAudio = '';

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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10.0),
                      child: FadeIn(
                        child: const Text(
                          'Great, let\'s start with some questions about you and what makes you unique. These questions will cover your background, values, and what shapes your world. Please take your time and answer as honestly as possible.',
                          style: TextStyle(
                            color: Color(0xFF6C2EBC),
                            fontSize: 20,
                            fontFamily: Strings.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    FadeIn(
                      child: Chip(
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
                    ),
                    SizedBox(height: size.height * 0.01),
                    _ChatAI(size: size),
                    _ChatUser(size: size),
                    urlAudio != ""
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                VoiceMessage(
                                  contactBgColor: Colors.purple.shade300,
                                  meBgColor: Colors.purple.shade300,
                                  mePlayIconColor: Color(0xFF6D2EBC),
                                  meFgColor: Color(0xFF6D2EBC),
                                  contactPlayIconBgColor: Colors.white,
                                  contactPlayIconColor: Colors.white,
                                  audioSrc: urlAudio,
                                  played: false, // To show played badge or not.
                                  me: true, // Set message side.
                                  onPlay:
                                      () {}, // Do something when voice played.
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.08,
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.only(left: 4.0, right: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SocialMediaRecorder(
                  initRecordPackageWidth: 60,
                  fullRecordPackageHeight: 60,
                  backGroundColor: const Color(0xFFCCC2EB),
                  counterBackGroundColor: const Color(0xFFCCC2EB),
                  cancelTextBackGroundColor: const Color(0xFFCCC2EB),
                  recordIconWhenLockBackGroundColor: const Color(0xFF6D2EBC),
                  recordIconBackGroundColor: const Color(0xFF6D2EBC),
                  radius: BorderRadius.circular(100),
                  sendRequestFunction: (soundFile, _time) async {
                    // soundFile represent the sound you recording
                    print('Se mando el audio absolute ${soundFile.absolute}');
                    print('Se mando el audio path ${soundFile.path}');
                    // var statusAudio = await Permission.audio.request();
                    var statusMicro = await Permission.microphone.request();
                    if (statusMicro.isGranted) {
                      setState(() {
                        urlAudio = soundFile.path;
                      });
                    }
                  },
                  encode: AudioEncoderType.AAC,
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
    return FadeIn(
      child: Column(
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
      ),
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
    return FadeIn(
      child: Column(
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
      ),
    );
  }
}
