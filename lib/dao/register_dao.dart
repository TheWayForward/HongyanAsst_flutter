import 'dart:io';

import 'package:hongyanasst/http/core/hi_net.dart';
import 'package:hongyanasst/http/request/register_request.dart';
import 'package:flutter/services.dart';

class RegisterDao {
  static register(
      String nickname, String email, String tel, String password) async {
    // username, nickname, email, tel, password
    var request = new RegisterRequest();
    request.add("nickname", nickname);
    request.add("email", email);
    request.add("tel", tel);
    request.add("password", password);
    request.add("from_client", Platform.isAndroid ? "android" : "IOS");
    var result = await HiNet.getInstance().fire(request);
    return result;
  }
}
