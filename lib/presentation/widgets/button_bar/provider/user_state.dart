class UserState {
  final String name;
  final bool isConnected;
  bool isSelected;

  UserState({
    required this.name,
    required this.isConnected,
    this.isSelected = false,
  });
}
