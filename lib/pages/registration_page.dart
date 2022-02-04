import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/dao/phone_captcha_dao.dart';
import 'package:hongyanasst/navigator/hi_navigator.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/message_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/utils/verification_helper.dart';
import 'package:hongyanasst/widgets/common_app_bar.dart';
import 'package:hongyanasst/widgets/common_input.dart';
import 'package:hongyanasst/widgets/copyright_text.dart';
import 'package:hongyanasst/widgets/digit_captcha.dart';
import 'package:hongyanasst/widgets/large_button.dart';
import 'package:hongyanasst/widgets/single_checkbox.dart';
import 'package:hongyanasst/widgets/toast.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String _nickname = "";
  String _password = "";
  String _rePassword = "";
  String _tel = "";
  String _captcha = "";
  String _email = "";

  bool _repsswordEnable = false;
  bool _captchaEnable = false;

  bool _confirm = false;
  bool _registerEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppBar(TagHelper.register_ch, true),
      body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              SizedBox(height: 20),
              _nicknameInput(),
              _passwordInput(),
              _rePasswordInput(),
              _telInput(),
              _captchaInput(),
              _emailInput(),
              _confirmCheckBox(),
              LargeButton(TagHelper.register_ch,
                  enable: _registerEnable, onPressed: _register),
              SizedBox(height: 50),
              CopyRightText(),
              SizedBox(height: 20)
            ],
          )),
    );
  }

  _nicknameInput() {
    return CommonInput(
        inputFormatters: [
          LengthLimitingTextInputFormatter(20),
          FilteringTextInputFormatter.deny(RegExp("[ ]"))
        ],
        hint: TagHelper.nickname_ch,
        helperText: TagHelper.nickname_helper_text_ch,
        obscureText: false,
        onChanged: (String text) {
          _nickname = text;
          _checkInput();
        },
        focusChanged: (bool focus) {},
        keyboardType: TextInputType.text);
  }

  _passwordInput() {
    return CommonInput(
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
        keyboardType: TextInputType.text);
  }

  _rePasswordInput() {
    return CommonInput(
        enabled: _repsswordEnable,
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
        keyboardType: TextInputType.text);
  }

  _telInput() {
    return CommonInput(
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
        keyboardType: TextInputType.number);
  }

  _captchaInput() {
    return DigitCaptcha(
        countdown: 60,
        enabled: _captchaEnable,
        canSend: true,
        maxLength: 6,
        onChanged: (String text) {
          _captcha = text;
          print(_captcha);
          _checkInput();
        });
  }

  _emailInput() {
    return CommonInput(
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
        keyboardType: TextInputType.emailAddress);
  }

  _confirmCheckBox() {
    return SingleCheckbox(
      value: _confirm,
      content: TagHelper.user_term_confirm_ch,
      onTextTap: _onJumpToUserTerm,
      onChanged: (bool? value) {
        setState(() {
          _confirm = value!;
        });
        _checkInput();
      },
    );
  }

  _onJumpToUserTerm() {
    HiNavigator.getInstance().onJumpTo(RouteStatus.user_term, args: {});
  }

  _checkInput() {
    setState(() {
      _repsswordEnable = _password.length >= 8;
      _captchaEnable = VerificationHelper.telVerification(_tel);
      if (_nickname != "" &&
          _password != "" &&
          _rePassword != "" &&
          _tel != "" &&
          _captcha != "" &&
          _email != "" && _confirm) {
        _registerEnable = true;
      }
    });
  }

  _register() async {
    String error = "";
    if (!VerificationHelper.nicknameVerification(_nickname)) {
      error += error == ""
          ? MessageHelper.nickname_illegal_ch
          : (MessageHelper.crlf + MessageHelper.nickname_illegal_ch);
    }
    if (!VerificationHelper.passwordVerification(_password)) {
      error += error == ""
          ? MessageHelper.password_illegal_ch
          : (MessageHelper.crlf + MessageHelper.password_illegal_ch);
    }
    if (_password != _rePassword) {
      error += error == ""
          ? MessageHelper.repassword_illegal_ch
          : (MessageHelper.crlf + MessageHelper.repassword_illegal_ch);
    }
    if (!VerificationHelper.telVerification(_tel)) {
      error += error == ""
          ? MessageHelper.tel_illegal_ch
          : (MessageHelper.crlf + MessageHelper.tel_illegal_ch);
    }
    if (!VerificationHelper.emailVerification(_email)) {
      error += error == ""
          ? MessageHelper.email_illegal_ch
          : (MessageHelper.crlf + MessageHelper.email_illegal_ch);
    }
    if (error != "") {
      ShowToast.showToast(error);
      return;
    }
    ShowToast.showToast("register");
  }
}
