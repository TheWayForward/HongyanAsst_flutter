import 'package:hongyanasst/db/hi_cache.dart';
import 'package:hongyanasst/http/core/hi_net.dart';
import 'package:hongyanasst/http/request/base_request.dart';
import 'package:hongyanasst/http/request/login_request.dart';
import 'package:hongyanasst/http/request/registration_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password,
      {String? imoocId, String? orderId}) async {
    BaseRequest request = LoginRequest();
    request.add("username", userName);
    request.add("password", password);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      // login succeed, save boarding pass
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
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
