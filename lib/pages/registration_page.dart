import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/widgets/common_app_bar.dart';
import 'package:hongyanasst/widgets/common_input.dart';
import 'package:hongyanasst/widgets/copyright_text.dart';
import 'package:hongyanasst/widgets/large_button.dart';
import 'package:hongyanasst/widgets/single_checkbox.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;

  const RegistrationPage({Key? key, required this.onJumpToLogin})
      : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String _username = "";
  String _password = "";
  String _rePassword = "";
  String _tel = "";
  String _email = "";
  bool _confirm = false;
  bool _registerEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: commonAppBar(TagHelper.register_ch, true),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Stack(children: [
            ListView(
              children: [
                CommonInput(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                      FilteringTextInputFormatter.deny(RegExp("[ ]"))
                    ],
                    hint: TagHelper.username_ch,
                    helperText: TagHelper.username_helper_text_ch,
                    obscureText: false,
                    onChanged: (String text) {
                      _username = text;
                      _checkInput();
                    },
                    focusChanged: (bool focus) {},
                    keyboardType: TextInputType.text),
                CommonInput(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.deny(RegExp("[ ]"))
                    ],
                    hint: TagHelper.password_ch,
                    helperText: TagHelper.password_helper_text_ch,
                    obscureText: true,
                    onChanged: (String text) {
                      _password = text;
                      _checkInput();
                    },
                    focusChanged: (bool focus) {},
                    keyboardType: TextInputType.text),
                CommonInput(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.deny(RegExp("[ ]"))
                    ],
                    hint: TagHelper.rePassword_ch,
                    helperText: TagHelper.password_helper_text_ch,
                    obscureText: true,
                    onChanged: (String text) {
                      _rePassword = text;
                      _checkInput();
                    },
                    focusChanged: (bool focus) {},
                    keyboardType: TextInputType.text),
                CommonInput(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.deny(RegExp("[ ]"))
                    ],
                    hint: TagHelper.tel_ch,
                    helperText: TagHelper.tel_helper_text_ch,
                    onChanged: (String text) {
                      _tel = text;
                      _checkInput();
                    },
                    focusChanged: (bool focus) {},
                    keyboardType: TextInputType.number),
                CommonInput(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                      FilteringTextInputFormatter.deny(RegExp("[ ]"))
                    ],
                    hint: TagHelper.email_ch,
                    helperText: TagHelper.email_helper_text_ch,
                    onChanged: (String text) {
                      _email = text;
                      _checkInput();
                    },
                    focusChanged: (bool focus) {},
                    keyboardType: TextInputType.emailAddress),
                SingleCheckbox(
                  value: _confirm,
                  content: TagHelper.user_term_confirm_ch,
                  onTextTap: _readTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _confirm = value!;
                    });
                    _checkInput();
                  },
                ),
                LargeButton(TagHelper.register_ch,
                    enable: _registerEnable, onPressed: () {})
              ],
            ),
            Positioned(child: CopyRightText(), left: 0, right: 0, bottom: 0)
          ]),
        ));
  }

  _checkInput() {

  }

  _readTerms() {

  }
}
