import 'dart:math';

class VerificationHelper {
  static bool isNotEmpty(String text) {
    return text.isNotEmpty;
  }

  static bool isEmpty(String text) {
    return text.isEmpty;
  }

  static bool usernameVerification(String username) {
    return RegExp(r"^[0-9a-zA-Z_]{1,}$").hasMatch(username);
  }

  static bool passwordVerification(String password) {
    return RegExp(r"^[0-9a-zA-Z_]{1,}$").hasMatch(password);
  }

  static bool emailVerification(String email) {
    return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(email);
  }

  static bool telVerification(String tel) {
    return RegExp(r"^[1][3,4,5,7,8][0-9]{9}$").hasMatch(tel);
  }

  static bool URLVerification(String URL) {
    return RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+").hasMatch(URL);
  }

  static bool ChineseVerification(String value) {
    return RegExp(r"[\u4e00-\u9fa5]").hasMatch(value);
  }
}
