import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hongyanasst/dao/get_data_dao.dart';
import 'package:hongyanasst/dao/login_dao.dart';
import 'package:hongyanasst/db/hi_cache.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/models/user_model.dart';
import 'package:hongyanasst/navigator/hi_navigator.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/message_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/utils/view_helper.dart';
import 'package:hongyanasst/widgets/avatar_container.dart';
import 'package:hongyanasst/widgets/common_dialog.dart';
import 'package:hongyanasst/widgets/hi_blur.dart';
import 'package:hongyanasst/widgets/hi_flexible_header.dart';
import 'package:hongyanasst/widgets/image_crop_pick.dart';
import 'package:hongyanasst/widgets/large_button.dart';
import 'package:hongyanasst/widgets/loading_mask.dart';
import 'package:hongyanasst/widgets/toast.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  UserModel? _userModel;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (_userModel == null) {
      LoadingMask.showLoading(MessageHelper.loading_indication_ch);
      _getUserData();
    }
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_userModel != null) {
      return Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_buildAppBar()];
          },
          body: ListView(
            padding: EdgeInsets.only(top: 10),
            children: [..._buildContentList()],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _getUserData() async {
    var id = HiCache.getInstance().get(LoginDao.USER_ID);
    try {
      UserModel result = await GetDataDao.getUserDataById(id);
      setState(() {
        _userModel = result;
      });
      LoadingMask.dismiss();
    } on NeedAuth catch (e) {
    } on NeedLogin catch (e) {
    } on HiNetError catch (e) {}
  }

  _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      elevation: 2,
      backgroundColor: ColorHelper.primary,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
                child: ViewHelper.cachedImage(_userModel!.avatar, true)),
            Positioned.fill(child: HiBlur(sigma: 20, child: Container())),
            Positioned(top: 75, left: 0, right: 0, child: _buildHideStuff())
          ],
        ),
      ),
    );
  }

  _buildHead() {
    if (_userModel == null) return Container();
    return HiFlexibleHeader(
        nickname: _userModel!.nickname,
        avatar: _userModel!.avatar,
        scrollController: _scrollController);
  }

  _buildHideStuff() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        AvatarContainer(avatar: _userModel!.avatar),
        SizedBox(width: 20),
        Container(
          height: 80,
          width: 200,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorHelper.primary)),
          child: Text(_userModel!.detail,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
        )
      ]),
    ]);
  }

  _buildUserDetail() {
    return;
  }

  _buildProfileTab() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTitleText(
              TagHelper.team_ch, _userModel!.credit, _onJumpToUserTeam),
          SizedBox(width: 5),
          _buildTitleText(
              TagHelper.bicycle_ch, _userModel!.credit, _onJumpToUserBicycle),
          SizedBox(width: 5),
          _buildTitleText(
              TagHelper.event_ch, _userModel!.credit, _onJumpToUserEvent),
          SizedBox(width: 5),
          _buildTitleText(
              TagHelper.moment_ch, _userModel!.credit, _onJumpToUserMoment),
          SizedBox(width: 5),
          _buildTitleText(
              TagHelper.credit_ch, _userModel!.credit, _onJumpToUserCredit),
        ],
      ),
    );
  }

  _buildTitleText(String text, int count, VoidCallback onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            child: Column(
          children: [
            Text('$count',
                style: TextStyle(fontSize: 15, color: Colors.black87)),
            Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        )));
  }

  _buildContentList() {
    return [_buildProfileTab(), Divider(), ..._buildOptions()];
  }

  _buildOptions() {
    return [
      ListTile(
          leading: Icon(Icons.manage_accounts),
          title: Text(TagHelper.profile_edit_ch),
          subtitle: Text(TagHelper.profile_edit_subtitle_ch),
          onTap: _onJumpToProfileEdit),
      ListTile(
          leading: Icon(Icons.account_tree_outlined),
          title: Text(TagHelper.manager_function_ch),
          subtitle: Text(TagHelper.manager_function_subtitle_ch),
          onTap: () {}),
      ListTile(
          leading: Icon(Icons.bug_report_outlined),
          title: Text(TagHelper.bug_report_ch),
          subtitle: Text(TagHelper.bug_report_subtitle_ch),
          onTap: () {}),
      ListTile(
          leading: Icon(Icons.settings),
          title: Text(TagHelper.app_settings_ch),
          subtitle: Text(TagHelper.app_settings_subtitle_ch),
          onTap: () {}),
      ListTile(
          leading: Icon(Icons.info_outlined),
          title: Text(TagHelper.about_ch),
          subtitle: Text(TagHelper.about_subtitle_ch),
          onTap: () {})
    ];
  }

  _onJumpToUserTeam() {
    print("k");
  }

  _onJumpToUserBicycle() {
    print("k");
  }

  _onJumpToUserEvent() {
    print("k");
  }

  _onJumpToUserMoment() {
    print("k");
  }

  _onJumpToUserCredit() {
    print("k");
  }

  _onJumpToProfileEdit() {
    HiNavigator.getInstance()
        .onJumpTo(RouteStatus.profile_edit, args: {"userModel": _userModel});
  }

  _showLogoutDialog() async {
    var result = await commonDialog(context,
        title: TagHelper.notice_ch, message: MessageHelper.logout_ask_ch);
    if (result == OkCancelResult.ok) {
      // confirm logout
      HiCache.getInstance().remove(LoginDao.BOARDING_PASS);
      HiNavigator.getInstance().onJumpTo(RouteStatus.login, args: {});
      ShowToast.showToast(MessageHelper.logout_succeed_ch);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
