import 'package:hongyanasst/http/request/base_request.dart';

class RegistrationRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
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
    return "/uapi/user/registration";
    // TODO: implement path
    throw UnimplementedError();
  }

  bool needUpload() {
    return false;
  }

}