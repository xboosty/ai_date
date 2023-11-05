import 'package:flutter/material.dart';

import '../../../../config/config.dart' show Strings;
import '../bloqued_list/bloqued_list_screen.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.person_pin),
          title: Text(
            'ACCOUNT',
            style: TextStyle(
              color: Color(0xFF686E8C),
              fontSize: 14,
              fontFamily: Strings.fontFamily,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: size.width * 0.90,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text(
                  'Pause Account',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Pausing prevents your profile from being shown to new people',
                  style: TextStyle(
                    color: Color(0xFFBDC0D6),
                    fontSize: 12,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              const Divider(),
              SwitchListTile(
                title: const Text(
                  'Active Dark Mode',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: false,
                onChanged: (value) {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Profile Control',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Bloqued list',
                  style: TextStyle(
                    color: Color(0xFF686E8C),
                    fontSize: 14,
                    fontFamily: Strings.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.0,
                ),
                onTap: () => Navigator.of(context)
                    .pushNamed(BloquedListScreen.routeName),
              )
            ],
          ),
        ),
      ],
    );
  }
}
