import 'package:package_info_plus/package_info_plus.dart';

class VersionApp {
  static Future<String> getVersionApp() async {
    String version;
    try {
      version =
          await PackageInfo.fromPlatform().then((packai) => packai.version);
    } catch (e) {
      version = '';
    }
    return version;
  }
}
