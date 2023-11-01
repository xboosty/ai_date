import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/button_card_provider.dart';

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

    return GestureDetector(
      onTap: () {
        buttonCardProvider.selectUser(index);
      },
      child: Card(
        color: user.isConnected ? Colors.blue : Colors.grey,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: user.isConnected ? Colors.green : Colors.red,
              radius: 20,
              child: const SizedBox(),
            ),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
