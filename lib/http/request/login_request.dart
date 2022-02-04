import 'package:hongyanasst/http/request/base_request.dart';

class LoginRequest extends BaseRequest {
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
    return "/api/v1/login";
  }

  @override
  bool needUpload() {
    return false;
  }
}
