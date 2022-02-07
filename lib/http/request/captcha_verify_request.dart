import 'package:hongyanasst/http/request/base_request.dart';

class VerifyCaptchaRequest extends BaseRequest {
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
    return "/api/v1/verify_captcha";
  }

  bool needUpload() {
    return false;
  }

}