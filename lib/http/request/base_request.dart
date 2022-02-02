import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/utils/config_helper.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = false;

  String authority() {
    // IP of localhost under android
    return "10.0.2.2:8000";
    // return "127.0.0.1:8000";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathString = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathString = "${path()}$pathParams";
      } else {
        pathString = "${path()}/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathString, params);
    } else {
      uri = Uri.http(authority(), pathString, params);
    }
    if (needLogin()) {
      // add boarding pass to interfaces
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    print('url: ${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  // add params
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = ConfigHelper.header;

  // add header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }


}