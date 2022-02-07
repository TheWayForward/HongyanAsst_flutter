import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/dao/captcha_dao.dart';
import 'package:hongyanasst/dao/test_dao.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/widgets/hi_bottom_sheet.dart';
import 'package:hongyanasst/widgets/image_crop_pick.dart';
import 'package:hongyanasst/widgets/text_area_input.dart';
import 'package:hongyanasst/widgets/toast.dart';
import 'package:city_pickers/city_pickers.dart';

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
      child: ElevatedButton(onPressed: () {

      }, child: Text("picker")),
    );
  }

  _test() async {
    var result = await TestDao.get();
    print(result);
  }
}
