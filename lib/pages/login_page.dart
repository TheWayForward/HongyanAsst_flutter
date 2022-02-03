import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/db/hi_cache.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/navigator/hi_navigator.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/message_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/utils/verification_helper.dart';
import 'package:hongyanasst/widgets/common_app_bar.dart';
import 'package:hongyanasst/widgets/common_input.dart';
import 'package:hongyanasst/widgets/copyright_text.dart';
import 'package:hongyanasst/widgets/href.dart';
import 'package:hongyanasst/widgets/large_button.dart';
import 'package:hongyanasst/widgets/loading_mask.dart';
import 'package:hongyanasst/widgets/single_checkbox.dart';
import 'package:hongyanasst/widgets/toast.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onJumpToRegistration;
  final VoidCallback onJumpToUserTerm;
  final VoidCallback onJumpToRetrievePassword;
  final VoidCallback onSuccess;

  const LoginPage(
      {Key? key,
      required this.onJumpToRegistration,
      required this.onJumpToUserTerm,
      required this.onJumpToRetrievePassword,
      required this.onSuccess})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = "";
  String _password = "";
  bool _loginEnable = false;
  bool _confirm = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppBar(TagHelper.login_ch, true),
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
              SingleCheckbox(
                value: _confirm,
                content: TagHelper.user_term_confirm_ch,
                onTextTap: widget.onJumpToUserTerm,
                onChanged: (bool? value) {
                  setState(() {
                    _confirm = value!;
                  });
                  _checkInput();
                },
              ),
              LargeButton(TagHelper.login_ch, enable: true, onPressed: () {
                _login();
              }),
              SizedBox(height: 50),
              Href(
                  inlineSpanList: TagHelper.register_link_richtext,
                  onTapLink: widget.onJumpToRegistration),
              Href(
                  inlineSpanList: TagHelper.forgot_password_link_richtext,
                  onTapLink: widget.onJumpToRetrievePassword),
            ],
          ),
          Positioned(child: CopyRightText(), left: 0, right: 0, bottom: 0)
        ]),
      ),
    );
  }

  _checkInput() {
    bool enable;
    if (VerificationHelper.isNotEmpty(_username) &&
        VerificationHelper.isNotEmpty(_password) &&
        _confirm) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      _loginEnable = enable;
    });
  }

  _login() async {
    String error = "";
    String type = "";
    bool isUsername = VerificationHelper.usernameVerification(_username);
    bool isEmail = VerificationHelper.emailVerification(_username);
    bool isTel = VerificationHelper.telVerification(_username);

    // if (!isUsername && !isEmail && !isTel) {
    //   error += MessageHelper.username_illegal_ch;
    // }
    //
    // if (!VerificationHelper.passwordVerification(_password)) {
    //   error += error == ""
    //       ? MessageHelper.password_illegal_ch
    //       : (MessageHelper.breaker + MessageHelper.password_illegal_ch);
    // }
    //
    // if (error != "") {
    //   ShowToast.showToast(error);
    //   return;
    // }
    //
    // if (isUsername) {
    //   type = "username";
    // } else if (isEmail) {
    //   type = "email";
    // } else {
    //   type = "tel";
    // }

    LoadingMask.showLoading(MessageHelper.loading_indication_ch);
    try {
      var result = await LoginDao.login("username_1", "Sam_2019", "username");
      print(result["token"]);
      LoadingMask.dismiss();
      ShowToast.showToast(MessageHelper.login_succeed_ch);
      HiNavigator.getInstance().onJumpTo(RouteStatus.home, args: {});
    } on NoContent catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showError(MessageHelper.user_DNE_ch);
      print(e.toString());
    } on NeedAuth catch (e) {
      print(e.toString());
    } on HiNetError catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showError(MessageHelper.internal_error_ch);
    }
  }
}
