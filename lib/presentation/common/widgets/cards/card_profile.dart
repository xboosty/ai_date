import 'package:flutter/material.dart';

import '../../../../config/config.dart' show AppTheme, Strings;
import '../../../../domain/domain.dart' show UserEntity;

class CardProfile extends StatelessWidget {
  const CardProfile({
    super.key,
    required this.user,
    required this.imageProvider,
  });

  final UserEntity user;
  final ImageProvider<Object> imageProvider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppTheme.linearGradient,
      ),
      child: Container(
        width: size.width * 0.78,
        height: size.height * 0.50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: AppTheme.shadowGradient(
                  begin: Alignment.bottomCenter,
                  end: const Alignment(0.0, 0.2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        icon: const Icon(
                          Icons.note_add_rounded,
                          color: Color(0xFFD9D9D9),
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${user.name} (24)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    'Lives in New York',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: Strings.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      '95% match',
                      style: TextStyle(
                        color: Color(0xFF9CA4BF),
                        fontSize: 12,
                        fontFamily: Strings.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
