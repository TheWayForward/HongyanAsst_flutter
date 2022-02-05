import 'package:flutter/material.dart';
import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/dao/phone_captcha_dao.dart';
import 'package:hongyanasst/dao/test_dao.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/widgets/hi_bottom_sheet.dart';
import 'package:hongyanasst/widgets/image_crop_pick.dart';
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
    return Center(
      child: ElevatedButton(
        onPressed: _crop,
        child: Text("get homepage data"),
      ),
    );
  }

  _crop() {
    imageCropPick(context);
  }

  _test() async {
    var result = await TestDao.get();
    print(result);
  }
}
