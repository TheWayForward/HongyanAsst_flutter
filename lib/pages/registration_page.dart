import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/dao/captcha_dao.dart';
import 'package:hongyanasst/dao/register_dao.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
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
import 'package:hongyanasst/widgets/loading_mask.dart';
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
  bool _initialSend = true;

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
              _buildNicknameInput(),
              _buildPasswordInput(),
              _buildRePasswordInput(),
              _buildTelInput(),
              _buildCaptchaInput(),
              _buildEmailInput(),
              _buildConfirmCheckBox(),
              LargeButton(TagHelper.register_ch,
                  enable: _registerEnable, onPressed: _register),
              SizedBox(height: 50),
              CopyRightText(),
              SizedBox(height: 20)
            ],
          )),
    );
  }

  _buildNicknameInput() {
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

  _buildPasswordInput() {
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

  _buildRePasswordInput() {
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

  _buildTelInput() {
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

  _buildCaptchaInput() {
    return DigitCaptcha(
      countdown: 60,
      captchaType: CaptchaType.phone,
      enabled: _captchaEnable,
      maxLength: 6,
      onChanged: (String text) {
        _captcha = text;
        _checkInput();
      },
      inputContent: _tel,
    );
  }

  _buildEmailInput() {
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

  _buildConfirmCheckBox() {
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
      if (_nickname.length >= 4 &&
          _password.length >= 8 &&
          _password.length >= 8 &&
          _tel.length == 11 &&
          _captcha.length == 6 &&
          _email.length >= 3 &&
          _confirm) {
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
      LoadingMask.showInfo(error);
      return;
    }
    // can register now
    LoadingMask.showLoading(MessageHelper.loading_indication_ch);
    try {
      var result = await CaptchaDao.verifyCaptcha(_captcha, CaptchaType.phone, tel: _tel);
      try {
        var result =
            await RegisterDao.register(_nickname, _email, _tel, _password);
        LoadingMask.dismiss();
        LoadingMask.showSuccess(MessageHelper.register_succeed);
        try {
          var result = await LoginDao.login(_tel, _password, "tel");
          HiNavigator.getInstance().onJumpTo(RouteStatus.home, args: {});
        } on HiNetError catch (e) {
          LoadingMask.showError(e.message);
        }
      } on NeedAuth catch (e) {
        LoadingMask.dismiss();
        LoadingMask.showInfo(e.message);
      } on NoContent catch (e) {
        LoadingMask.dismiss();
        LoadingMask.showInfo(e.message);
      } on HiNetError catch (e) {
        LoadingMask.dismiss();
        LoadingMask.showError(e.message);
      }
    } on NeedAuth catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showInfo(e.message);
    } on NoContent catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showInfo(e.message);
    } on HiNetError catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showError(e.message);
    }
  }
}
