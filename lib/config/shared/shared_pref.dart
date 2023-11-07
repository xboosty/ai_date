import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final SharedPref pref = SharedPref._();

  SharedPreferences? preferences;

  SharedPref._();

  Future<void> initPrefer() async {
    preferences = await SharedPreferences.getInstance();
  }

  // Getters
  bool get showApp => preferences?.getBool('showApp') ?? true;
  bool get showFirstInterviewPage =>
      preferences?.getBool('showFirstInterviewPage') ?? true;
  bool get isRememberCredential =>
      preferences?.getBool('isRememberCredential') ?? false;
  List<String> get loginCredential =>
      preferences?.getStringList('credentials') ?? [];
  String get token => preferences?.getString('token') ?? 'null';
  String get account => preferences?.getString('account') ?? '{}';
  String get tokenAI => preferences?.getString('tokenAI') ?? '';

  // Setters
  set showApp(bool flag) => preferences?.setBool('showApp', flag);
  set showFirstInterviewPage(bool flag) =>
      preferences?.setBool('showFirstInterviewPage', flag);
  set isRememberCredential(bool flag) =>
      preferences?.setBool('isRememberCredential', flag);
  set loginCredential(List<String> credentials) =>
      preferences?.setStringList('credentials', credentials);

  set token(String newToken) => preferences?.setString('token', newToken);
  set account(String newAccount) =>
      preferences?.setString('account', newAccount);
  set tokenAI(String newTokenAI) =>
      preferences?.setString('tokenAI', newTokenAI);
}
