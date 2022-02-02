import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/config_helper.dart';

class CopyRightText extends StatelessWidget {
  const CopyRightText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Version ${ConfigHelper.version}",
          style: TextStyle(color: Colors.grey, fontSize: 12)),
      SizedBox(height: 10),
      Text(
          "Copyright © Team HongyanAsst 2020-2022",
          style: TextStyle(color: Colors.grey, fontSize: 12))
    ]);
  }
}
