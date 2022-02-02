import 'package:hongyanasst/http/request/base_request.dart';

class LoginRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
    // TODO: implement httpMethod
    throw UnimplementedError();
  }

  @override
  bool needLogin() {
    return false;
    // TODO: implement needLogin
    throw UnimplementedError();
  }

  @override
  String path() {
    return "/api/v1/test";
    // TODO: implement path
    throw UnimplementedError();
  }

}