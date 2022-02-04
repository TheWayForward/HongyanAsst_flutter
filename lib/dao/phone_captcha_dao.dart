import 'package:hongyanasst/http/core/hi_net.dart';
import 'package:hongyanasst/http/request/base_request.dart';
import 'package:hongyanasst/http/request/phone_captcha_request.dart';
import 'package:hongyanasst/http/request/phone_captcha_verify_request.dart';

class PhoneCaptchaDao {
  static get(String tel) async{
    BaseRequest request = PhoneCaptchaRequest();
    request.add("tel", tel);
    var result = await HiNet.getInstance().fire(request);
    return result;
  }

  static verify(String tel, String content) async {
    BaseRequest request = VerifyPhoneCaptchaRequest();
    request.add("send_to", "phone");
    request.add("tel", tel);
    request.add("content", content);
    var result = await HiNet.getInstance().fire(request);
    return result;
  }
}