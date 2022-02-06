import 'package:flutter/material.dart';
import 'package:hongyanasst/models/user_model.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/widgets/avatar_container.dart';
import 'package:hongyanasst/widgets/common_app_bar.dart';
import 'package:hongyanasst/widgets/common_input.dart';
import 'package:hongyanasst/widgets/digit_captcha.dart';
import 'package:hongyanasst/widgets/image_crop_pick.dart';
import 'package:hongyanasst/widgets/large_button.dart';

class ProfileEditPage extends StatefulWidget {

  final UserModel userModel;

  const ProfileEditPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {

  String _tel = "";

  @override
  void initState() {
    super.initState();
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
      _buildNickNameOption(),
      _buildTelOption()
    ];
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
                hint: TagHelper.nickname_new_ch,
                helperText: TagHelper.nickname_helper_text_ch,
                onChanged: (value) {},
                focusChanged: (focus) {},
                keyboardType: TextInputType.text),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: LargeButton(TagHelper.confirm_ch))
        ]);
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
                hint: TagHelper.tel_new_ch,
                helperText: TagHelper.tel_helper_text_ch,
                onChanged: (value) {},
                focusChanged: (focus) {},
                keyboardType: TextInputType.number),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: DigitCaptcha(
                maxLength: 6, countdown: 60, onChanged: (value) {}, tel: _tel),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: LargeButton(TagHelper.confirm_ch))
        ]);
  }

  _changeAvatar() {
    imageCropPick(context);
  }
}
