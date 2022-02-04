import 'package:hongyanasst/http/request/base_request.dart';

class VerifyPhoneCaptchaRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/api/v1/verify_phone_captcha";
  }

}