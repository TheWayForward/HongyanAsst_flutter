import 'package:dio/dio.dart';
import 'package:hongyanasst/http/request/base_request.dart';
import 'hi_error.dart';
import 'hi_net_adapter.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(),
            options: options, queryParameters: request.params);
      } else if (request.httpMethod() == HttpMethod.POST) {
        print(request.params);
        if (request.needUpload()) {
          response = await Dio()
              .post(request.url(), data: request.formData, options: options);
        } else {
          response = await Dio()
              .post(request.url(), data: request.params, options: options);
        }
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
      if (error != null) {
        throw HiNetError(response?.statusCode ?? -1, error.toString(),
            data: await buildRes(response, request));
      }
    }
    return buildRes(response, request);
    // TODO: implement send
    throw UnimplementedError();
  }

  Future<HiNetResponse<T>> buildRes<T>(Response response, BaseRequest request) {
    return Future.value(HiNetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response));
  }
}
