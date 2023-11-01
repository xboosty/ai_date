import 'package:flutter/material.dart';

import 'user_state.dart';

class ButtonCardProvider with ChangeNotifier {
  final List<UserState> users;

  ButtonCardProvider({required this.users});

  void selectUser(int index) {
    for (var i = 0; i < users.length; i++) {
      users[i].isConnected = i == index;
    }
    notifyListeners();
  }
}
