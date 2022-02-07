import 'package:hongyanasst/http/request/base_request.dart';

class UpdateUserInfoRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  bool needUpload() {
    return false;
  }

  @override
  String path() {
    return "/api/v1/update_user_info_request";
  }

}