import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/user_chat_provider.dart';
import '../../../../config/config.dart' show AppTheme, Strings;

class UsersButtonBar extends StatelessWidget {
  const UsersButtonBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.15,
      padding: const EdgeInsets.only(left: 15.0),
      child: Consumer<ButtonCardProvider>(
        builder: (context, buttonCardProvider, child) {
          if (buttonCardProvider.users.isEmpty) {
            return const Center(
              child: Text('Empty users tray'),
            );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: buttonCardProvider.users.length,
            itemBuilder: (context, index) {
              return ButtonCard(index);
            },
          );
        },
      ),
    );
  }
}

class ButtonCard extends StatelessWidget {
  final int index;

  ButtonCard(this.index);

  @override
  Widget build(BuildContext context) {
    final buttonCardProvider = Provider.of<ButtonCardProvider>(context);
    final user = buttonCardProvider.users[index];
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        buttonCardProvider.selectUser(index);
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
            color: user.isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(20),
            gradient: user.isSelected ? AppTheme.linearGradientReverse : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/imgs/girl3.png'),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                user.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      user.isSelected ? Colors.white : const Color(0xFF7F87A6),
                  fontSize: 12,
                  fontFamily: Strings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
