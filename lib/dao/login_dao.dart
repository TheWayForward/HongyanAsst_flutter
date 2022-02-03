import 'package:hongyanasst/db/hi_cache.dart';
import 'package:hongyanasst/http/core/hi_net.dart';
import 'package:hongyanasst/http/request/base_request.dart';
import 'package:hongyanasst/http/request/login_request.dart';
import 'package:hongyanasst/http/request/registration_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  static login(String username, String password, String type) {
    return _send(username, password, type);
  }

  static _send(String username, String password, String type) async {
    BaseRequest request = LoginRequest();
    request.add("username", username);
    request.add("password", password);
    request.add("type", type);
    var result = await HiNet.getInstance().fire(request);
    if (result['code'] == 200 && result['token'] != null) {
      // login succeed, save boarding pass
      HiCache.getInstance().setString(BOARDING_PASS, result['token']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }

  static deleteBoardingPass() {
    return HiCache.getInstance().setString(BOARDING_PASS, "");
  }
}
