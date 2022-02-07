import 'package:hongyanasst/http/core/hi_net.dart';
import 'package:hongyanasst/http/request/base_request.dart';
import 'package:hongyanasst/http/request/email_captcha_request.dart';
import 'package:hongyanasst/http/request/phone_captcha_request.dart';
import 'package:hongyanasst/http/request/captcha_verify_request.dart';
import 'package:hongyanasst/widgets/digit_captcha.dart';

class CaptchaDao {
  static getPhoneCaptcha(String tel) async{
    BaseRequest request = PhoneCaptchaRequest();
    request.add("tel", tel);
    var result = await HiNet.getInstance().fire(request);
    return result;
  }

  static getEmailCaptcha(String email) async{
    BaseRequest request = EmailCaptchaRequest();
    request.add("email", email);
    var result = await HiNet.getInstance().fire(request);
    return result;
  }

  static verifyCaptcha(String captcha, CaptchaType captchaType, {String tel = "", String email = ""}) async {
    BaseRequest request = VerifyCaptchaRequest();
    if (captchaType == CaptchaType.phone) {
      request.add("send_to", "phone");
      request.add("tel", tel);
    } else {
      request.add("send_to", "email");
      request.add("email", email);
    }
    request.add("content", captcha);
    var result = await HiNet.getInstance().fire(request);
    return result;
  }


}