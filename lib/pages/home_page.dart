import 'package:flutter/material.dart';
import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/dao/phone_captcha_dao.dart';
import 'package:hongyanasst/dao/test_dao.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/widgets/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
                onPressed: _testRequest, child: Icon(Icons.send)))
      ],
    );
  }

  _testRequest() async {
    try {
      var result = await PhoneCaptchaDao.verify("18810559476", "836253");
      print(result);
    } on NeedAuth catch (e) {
      print(e.toString());
    } on NoContent catch (e) {
      print(e.toString());
    } on HiNetError catch (e) {
      print(e.toString());
    }
  }
}
