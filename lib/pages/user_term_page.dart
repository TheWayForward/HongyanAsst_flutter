import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/widgets/common_app_bar.dart';

class UserTermPage extends StatefulWidget {
  const UserTermPage({Key? key}) : super(key: key);

  @override
  _UserTermPageState createState() => _UserTermPageState();
}

class _UserTermPageState extends State<UserTermPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(TagHelper.user_term_ch, true),
      body: Center(
        child: Text(TagHelper.user_term_ch),
      ),
    );
  }
}
