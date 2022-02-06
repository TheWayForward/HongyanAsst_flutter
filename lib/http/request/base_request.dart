import 'package:dio/dio.dart';
import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/utils/config_helper.dart';
import 'package:http/http.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams;
  var useHttps = ConfigHelper.useHttps;

  String authority() {
    // IP of localhost under android
    return ConfigHelper.authority;
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

  bool needUpload();

  Map<String, dynamic> params = Map();

  FormData? formData;

  // set form data
  BaseRequest setFormData(FormData _formData) {
    formData = _formData;
    return this;
  }

  // add params
  BaseRequest add(String k, Object v) {
    params[k] = v;
    return this;
  }

  Map<String, dynamic> header = ConfigHelper.header;

  // add header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }

}