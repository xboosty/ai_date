import 'package:flutter/material.dart';

import '../../../../../config/config.dart' show AppTheme, Strings;

class LikeSentPage extends StatelessWidget {
  const LikeSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.3,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.linearGradientTopRightBottomLeft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage('assets/imgs/girl5.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Jennifer (24)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Lives in New York',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
