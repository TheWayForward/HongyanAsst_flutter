import 'package:hongyanasst/http/core/hi_net.dart';
import 'package:hongyanasst/http/request/test_request.dart';

class TestDao {
  static get() async {
    TestRequest request = TestRequest();
    var result = await HiNet.getInstance().fire(request);
    return result;
  }
}