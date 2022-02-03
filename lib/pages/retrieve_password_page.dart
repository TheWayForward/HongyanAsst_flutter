import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/widgets/common_app_bar.dart';

class RetrievePasswordPage extends StatefulWidget {
  final VoidCallback onSuccess;

  const RetrievePasswordPage({Key? key, required this.onSuccess})
      : super(key: key);

  @override
  _RetrievePasswordPageState createState() => _RetrievePasswordPageState();
}

class _RetrievePasswordPageState extends State<RetrievePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(TagHelper.password_retrieve_ch, true),
      body: Center(child: Text(TagHelper.password_retrieve_ch)),
    );
  }
}
