import 'dart:math';

class VerificationHelper {
  static bool isNotEmpty(String text) {
    return text.isNotEmpty;
  }

  static bool isEmpty(String text) {
    return text.isEmpty;
  }

  static bool usernameVerification(String username) {
    if (username.length < 4 || username.length > 16) {
      return false;
    }
    return RegExp(r"^(?![0-9]+$)[0-9A-Za-z]{8,20}$").hasMatch(username);
  }

  static bool nicknameVerification(String nickname) {
    if (nickname.length < 4 || nickname.length > 20) {
      return false;
    }
    return RegExp(r"^(?![0-9]+$)[0-9A-Za-z]{4,20}$").hasMatch(nickname);
  }

  static bool passwordVerification(String password) {
    if (password.length < 8 || password.length > 20) {
      return false;
    }
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
