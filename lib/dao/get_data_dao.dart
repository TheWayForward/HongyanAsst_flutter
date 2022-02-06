import 'package:hongyanasst/http/core/hi_net.dart';
import 'package:hongyanasst/http/request/base_request.dart';
import 'package:hongyanasst/http/request/get_user_data_by_id_request.dart';
import 'package:hongyanasst/models/user_model.dart';

class GetDataDao {

  static getUserDataById(String id) async{
    BaseRequest request = GetUserDataByIdRequest();
    request.add("id", id);
    var result = await HiNet.getInstance().fire(request);
    return UserModel.fromJson(result["data"]);
  }

}