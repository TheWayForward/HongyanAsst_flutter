import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/models/address_model.dart';
import 'package:hongyanasst/models/user_model.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/config_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/utils/verification_helper.dart';
import 'package:hongyanasst/widgets/avatar_container.dart';
import 'package:hongyanasst/widgets/common_app_bar.dart';
import 'package:hongyanasst/widgets/common_input.dart';
import 'package:hongyanasst/widgets/digit_captcha.dart';
import 'package:hongyanasst/widgets/hi_city_picker.dart';
import 'package:hongyanasst/widgets/image_crop_pick.dart';
import 'package:hongyanasst/widgets/large_button.dart';
import 'package:hongyanasst/widgets/text_area_input.dart';

class ProfileEditPage extends StatefulWidget {
  final UserModel userModel;

  const ProfileEditPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String _nickname = "";
  bool _nicknameEnable = false;
  AddressModel? _addressModel;
  String _detail = "";
  bool _detailEnable = false;
  String _tel = "";
  String _telCaptcha = "";
  bool _telEnable = false;
  String _email = "";
  String _emailCaptcha = "";
  bool _emailEnable = false;
  bool _captchaEnable = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _detail = widget.userModel.detail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(TagHelper.profile_edit_ch, true),
      body: ListView(children: [..._buildOptions()]),
    );
  }

  _buildOptions() {
    return [
      ListTile(
          title: Text(TagHelper.avatar_ch),
          trailing: AvatarContainer(avatar: widget.userModel.avatar),
          onTap: _changeAvatar),
      _buildDetailOption(),
      _buildNickNameOption(),
      _buildAddressOption(),
      _buildTelOption(),
      _buildEmailOption()
    ];
  }

  _buildDetailOption() {
    return ExpansionTile(
        title: Text(TagHelper.user_detail_ch),
        subtitle: Text(widget.userModel.detail,
            maxLines: 1, overflow: TextOverflow.ellipsis),
        textColor: ColorHelper.primary,
        iconColor: ColorHelper.primary,
        children: [
          TextAreaInput(
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    ConfigHelper.user_detail_max_length),
                FilteringTextInputFormatter.deny(RegExp("[ ]"))
              ],
              maxLength: ConfigHelper.user_detail_max_length,
              hint: TagHelper.user_detail_new_ch,
              content: _detail,
              onChanged: (text) {
                setState(() {
                  _detail = text;
                });
                _checkInput();
              },
              focusChanged: (focus) {},
              keyboardType: TextInputType.text),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: LargeButton(TagHelper.confirm_ch,
                  enable: _detailEnable, onPressed: _updateDetail))
        ]);
  }

  _buildNickNameOption() {
    return ExpansionTile(
        title: Text(TagHelper.nickname_ch),
        subtitle: Text(widget.userModel.nickname),
        textColor: ColorHelper.primary,
        iconColor: ColorHelper.primary,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: CommonInput(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                  FilteringTextInputFormatter.deny(RegExp("[ ]"))
                ],
                hint: TagHelper.nickname_new_ch,
                helperText: TagHelper.nickname_helper_text_ch,
                onChanged: (text) {
                  _nickname = text;
                  _checkInput();
                },
                focusChanged: (focus) {},
                keyboardType: TextInputType.text),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: LargeButton(TagHelper.confirm_ch,
                  enable: _nicknameEnable, onPressed: _updateNickname))
        ]);
  }

  _buildAddressOption() {
    return ExpansionTile(
        title: Text(TagHelper.live_address_ch),
        subtitle: Text(widget.userModel.addressModel.toString()),
        textColor: ColorHelper.primary,
        iconColor: ColorHelper.primary,
        children: [
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: LargeButton(TagHelper.address_pick_ch,
                  enable: true, onPressed: _pickAddress))
        ]);
  }

  _pickAddress() async {
    var result = await HiCityPicker.showCityPicker(context);
    if (result != null) {
      _addressModel = AddressModel.fromResult(result);
    }
  }

  _buildTelOption() {
    return ExpansionTile(
        title: Text(TagHelper.tel_ch),
        subtitle: Text(widget.userModel.tel),
        textColor: ColorHelper.primary,
        iconColor: ColorHelper.primary,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: CommonInput(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.deny(RegExp("[ ]"))
                ],
                hint: TagHelper.tel_new_ch,
                helperText: TagHelper.tel_helper_text_ch,
                onChanged: (text) {
                  _tel = text;
                  _checkInput();
                },
                focusChanged: (focus) {},
                keyboardType: TextInputType.number),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: DigitCaptcha(
                maxLength: 6,
                captchaType: CaptchaType.phone,
                countdown: 60,
                onChanged: (text) {
                  _telCaptcha = text;
                  _checkInput();
                },
                inputContent: _tel,
                enabled: _captchaEnable),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: LargeButton(TagHelper.confirm_ch,
                  enable: _telEnable, onPressed: _updateTel))
        ]);
  }

  _buildEmailOption() {
    return ExpansionTile(
        title: Text(TagHelper.email_ch),
        subtitle: Text(widget.userModel.email),
        textColor: ColorHelper.primary,
        iconColor: ColorHelper.primary,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: CommonInput(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(40),
                  FilteringTextInputFormatter.deny(RegExp("[ ]"))
                ],
                hint: TagHelper.email_new_ch,
                helperText: TagHelper.email_helper_text_ch,
                onChanged: (text) {
                  _email = text;
                  _checkInput();
                },
                focusChanged: (focus) {},
                keyboardType: TextInputType.emailAddress),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: DigitCaptcha(
                maxLength: 6,
                captchaType: CaptchaType.email,
                countdown: 60,
                onChanged: (text) {
                  _emailCaptcha = text;
                  _checkInput();
                },
                inputContent: _email,
                enabled: _captchaEnable),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: LargeButton(TagHelper.confirm_ch,
                  enable: _emailEnable, onPressed: _updateEmail))
        ]);
  }

  _checkInput() {
    setState(() {
      _nicknameEnable = VerificationHelper.nicknameVerification(_nickname) &&
          _nickname != widget.userModel.nickname;
      _detailEnable = _detail != "" && _detail != widget.userModel.detail;
      _emailEnable = VerificationHelper.emailVerification(_email) &&
          _email != widget.userModel.email &&
          _emailCaptcha.length == 6;
      _telEnable = VerificationHelper.telVerification(_tel) &&
          _tel != widget.userModel.tel &&
          _telCaptcha.length == 6;
      _captchaEnable = VerificationHelper.telVerification(_tel) &&
          _tel != widget.userModel.tel;
    });
  }

  _changeAvatar() {
    imageCropPick(context);
  }

  _updateDetail() {

  }

  _updateNickname() {

  }

  _updateTel() {

  }

  _updateEmail() {

  }


}
