import 'package:hongyanasst/dao/login_dao.dart';

class ConfigHelper {
  static bool useHttps = false;
  static String authority = "10.0.2.2:8000";
  static getAuthority({required bool useHttps}) {
    return "${useHttps ? "https://" : "http://"}${ConfigHelper.authority}";
  }
  static String version = "0.0.1";
  static String appFlagK = 'app-flag';
  static String appFlagV = 'hy';
  static String authTokenK = 'auth-token';
  static String authTokenV = 'ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa';
  static String fromK = 'from';
  static String fromV = 'android';
  static Map<String, dynamic> header = {
    ConfigHelper.authTokenK: ConfigHelper.authTokenV,
    ConfigHelper.appFlagK: ConfigHelper.appFlagV,
    ConfigHelper.fromK: ConfigHelper.fromV
  };
  static const theme = "hi_theme";
  static headers() {
    Map<String, dynamic> header = {
      ConfigHelper.authTokenK: ConfigHelper.authTokenV,
      ConfigHelper.appFlagK: ConfigHelper.appFlagV,
      ConfigHelper.fromK: ConfigHelper.fromV
    };
    header[LoginDao.BOARDING_PASS] = LoginDao.getBoardingPass();
    return header;
  }
}
