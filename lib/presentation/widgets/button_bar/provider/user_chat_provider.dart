import 'package:flutter/material.dart';

import 'user_state.dart';

class ButtonCardProvider with ChangeNotifier {
  final List<UserState> users;
  UserState? _userSelected;

  ButtonCardProvider({required this.users});

  UserState? get userSelected => _userSelected;

  void selectUser(int index) {
    for (var i = 0; i < users.length; i++) {
      users[i].isSelected = i == index;
      if (users[i].isSelected) {
        _userSelected = users[i];
      }
    }
    notifyListeners();
  }

  // UserState? getSelectedUser() {
  //   final selectedUser = users.firstWhere((user) => user.isSelected);
  //   return selectedUser;
  // }
}
