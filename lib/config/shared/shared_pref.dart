import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref pref = SharedPref._();

  SharedPreferences? preferences;

  SharedPref._();

  Future<void> initPrefer() async {
    preferences = await SharedPreferences.getInstance();
  }

  // Getters
  bool get showApp => preferences?.getBool('showApp') ?? false;
  bool get isRememberCredential =>
      preferences?.getBool('isRememberCredential') ?? false;
  List<String> get loginCredential =>
      preferences?.getStringList('credentials') ?? [];
  String get token => preferences?.getString('token') ?? 'null';

  // bool get allowNotifications => preferences?.getBool('notification') ?? false;
  // String get port => preferences?.getString('port') ?? '0';
  // String get database => preferences?.getString('database') ?? '';
  // String get userDB => preferences?.getString('userDB') ?? '';
  // String get passwordDB => preferences?.getString('passwordDB') ?? '';

  // getters for user and rol
  // String get user => preferences?.getString('user') ?? '';
  // String get rol => preferences?.getString('rol') ?? '';

  // Setters
  set showApp(bool flag) => preferences?.setBool('showApp', flag);
  set isRememberCredential(bool flag) =>
      preferences?.setBool('isRememberCredential', flag);
  set loginCredential(List<String> credentials) =>
      preferences?.setStringList('credentials', credentials);

  set token(String newToken) => preferences?.setString('token', newToken);
  // set allowNotifications(bool flag) =>
  //     preferences?.setBool('notification', flag);

  // set port(String newPort) => preferences?.setString('port', newPort);
  // set database(String newDatabase) =>
  //     preferences?.setString('database', newDatabase);
  // set userDB(String newUserDB) => preferences?.setString('userDB', newUserDB);
  // set passwordDB(String newPasswordDB) =>
  //     preferences?.setString('passwordDB', newPasswordDB);

  // // setters for user and rol
  // set user(String newUser) => preferences?.setString('user', newUser);
  // set rol(String newRol) => preferences?.setString('rol', newRol);
}
