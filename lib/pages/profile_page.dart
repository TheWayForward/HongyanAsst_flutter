import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/db/hi_cache.dart';
import 'package:hongyanasst/navigator/hi_navigator.dart';
import 'package:hongyanasst/utils/message_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/widgets/common_dialog.dart';
import 'package:hongyanasst/widgets/large_button.dart';
import 'package:hongyanasst/widgets/toast.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LargeButton(TagHelper.logout_ch,
          enable: true, onPressed: _showLogoutDialog),
    );
  }

  _showLogoutDialog() async {
    var result = await commonDialog(context,
        title: TagHelper.notice_ch, message: MessageHelper.logout_ask_ch);
    if (result == OkCancelResult.ok) {
      // confirm logout
      HiCache.getInstance().remove(LoginDao.BOARDING_PASS);
      HiNavigator.getInstance().onJumpTo(RouteStatus.login, args: {});
      ShowToast.showToast(MessageHelper.logout_succeed);
    }
  }
}
