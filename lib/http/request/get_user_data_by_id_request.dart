import 'package:hongyanasst/http/request/base_request.dart';

class GetUserDataByIdRequest extends BaseRequest{
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
    return "/api/v1/get_user_data_by_id";
  }

}