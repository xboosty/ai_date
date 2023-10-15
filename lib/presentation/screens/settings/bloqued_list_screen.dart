import 'package:flutter/material.dart';

import '../../../config/config.dart' show AppTheme, Strings;
import '../../widgets/widgets.dart' show FilledColorizedButton, GradientText;

class BloquedListScreen extends StatelessWidget {
  const BloquedListScreen({super.key});

  static const String routeName = '/bloqued_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Blocked',
          style: TextStyle(
            color: Color(0xFF261638),
            fontSize: 20,
            fontFamily: Strings.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          bottom: false,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  _UnbloquedProfile(),
                  Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _UnbloquedProfile extends StatelessWidget {
  const _UnbloquedProfile();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          enableDrag: true,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: 1.0,
              minChildSize: 1.0,
              maxChildSize: 1.0,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const Text(
                        'Bloqued user',
                        style: TextStyle(
                          color: Color(0xFF261638),
                          fontSize: 20,
                          fontFamily: Strings.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: size.height * 0.90,
                        margin: const EdgeInsets.only(top: 10.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/imgs/girl5.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _TitleUnblockUser(size: size),
                            const Spacer(),
                            _OpacityCardUnblock(size: size),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              controller: DraggableScrollableController(),
            );
          },
        );
      },
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/imgs/girl3.png'),
      ),
      title: const Text(
        'Jessica',
        style: TextStyle(
          color: Color(0xFF686E8C),
          fontSize: 14,
          fontFamily: Strings.fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: FilledButton(
        style: FilledButton.styleFrom(
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Unblock',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: Strings.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 5.0),
            Icon(Icons.published_with_changes_outlined)
          ],
        ),
      ),
    );
  }
}

class _TitleUnblockUser extends StatelessWidget {
  const _TitleUnblockUser({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.10,
      child: ListTile(
        title: const Text(
          'Samantha (31)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            height: 0.06,
          ),
        ),
        subtitle: const Text(
          'Lives in New York',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            height: 0.12,
          ),
        ),
        trailing: FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.6000000238418579),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          child: const GradientText(
            text: '95% match',
            gradient: AppTheme.linearGradient,
            style: TextStyle(
              fontSize: 12,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _OpacityCardUnblock extends StatelessWidget {
  const _OpacityCardUnblock({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.35,
      padding: const EdgeInsets.only(top: 30, bottom: 50, right: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white.withOpacity(0.10000000149011612),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'You\'ve blocked this user',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'If you want to see this user\'s details, unblock them first',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          FilledColorizedButton(
            width: 150,
            height: 50,
            title: 'Unblock',
            isTrailingIcon: true,
            icon: const Icon(
              Icons.published_with_changes_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
