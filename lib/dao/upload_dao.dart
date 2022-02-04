import 'package:dio/dio.dart';
import 'package:hongyanasst/http/core/hi_net.dart';
import 'package:hongyanasst/http/request/upload_avatar_request.dart';

class UploadDao {
  static uploadAvatar(String id, String fileDir) async {
    // get multipart file
    var file = await MultipartFile.fromFile(fileDir).then((_file) async{
      var request = UploadAvatarRequest();
      FormData formData = FormData.fromMap({
        "id": id,
        "file": _file
      });

      request.setFormData(formData);
      var result = await HiNet.getInstance().fire(request);
      return result;
    });
    return file;
  }
}