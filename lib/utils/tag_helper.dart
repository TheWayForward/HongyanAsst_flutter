import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/color_helper.dart';

class TagHelper {
  static const String bottom_navigation_homepage_ch = "主页";
  static const String bottom_navigation_community_ch = "社区";
  static const String bottom_navigation_moment_ch = "动态";
  static const String bottom_navigation_profilepage_ch = "我的";

  static const String confirm_ch = "确定";

  static const String cancel_ch = "取消";

  static const String notice_ch = "提示";

  static const String profile_edit_ch = "编辑资料";
  static const String profile_edit_subtitle_ch = "修改您的头像与其他个人信息";
  static const String manager_function_ch = "管理员功能";
  static const String manager_function_subtitle_ch = "管理鸿雁骑行平台软硬件数据";
  static const String bug_report_ch = "问题反馈";
  static const String bug_report_subtitle_ch = "向鸿雁骑行开发者反馈软硬件产品问题";
  static const String app_settings_ch = "应用设置";
  static const String app_settings_subtitle_ch = "管理应用权限、个性化设置";
  static const String about_ch = "关于";
  static const String about_subtitle_ch = "查看应用版本、开发日志、开发者信息";

  static const String credit_ch = "积分";
  static const String event_ch = "活动";
  static const String bicycle_ch = "单车";
  static const String moment_ch = "动态";
  static const String likes_ch = "点赞";
  static const String team_ch = "车队";

  static const String username_ch = "用户名";
  static const String username_register_helper_text_ch = "4-16位字母、数字";
  static const String username_helper_text_ch = "手机/email/账号";
  static const String username_indicator_ch = "请输入用户名";

  static const String avatar_ch = "头像";
  static const String change_avatar_ch = "更换头像";

  static const String image_from_gallery = "从相册选择";
  static const String image_from_camera = "拍照";

  static const String nickname_ch = "昵称";
  static const String nickname_new_ch = "新的昵称";
  static const String nickname_helper_text_ch = "4-20位字母、数字";

  static const String live_address_ch = "现居地";
  static const String address_pick_ch = "选择地址";

  static const String password_ch = "密码";
  static const String password_new_ch = "新的密码";
  static const String password_helper_text_ch = "8-20位字母、数字、下划线";
  static const String password_indicator_ch = "请输入密码";
  static const String password_retrieve_ch = "找回密码";

  static const String user_detail_ch = "个性签名";
  static const String user_detail_new_ch = "新的个性签名";
  static const String user_detail_helper_text_ch = "短小精悍,句短而意长";

  static const String send_ch = "发送";
  static const String resend_ch = "重发";

  static const String captcha_ch = "验证码";
  static const String captcha_helper_text_ch = "6位数字验证码";
  static const String send_captcha_ch = "发送验证码";
  static const String send_captcha_via_email_ch = "发送email验证码";
  static const String send_captcha_via_tel_ch = "发送手机验证码";

  static const String email_ch = "email";
  static const String email_new_ch = "新的email";
  static const String email_helper_text_ch = "电子邮箱";

  static const String rePassword_ch = "确认密码";

  static const String tel_ch = "手机";
  static const String tel_new_ch = "新的手机号码";
  static const String tel_helper_text_ch = "11位电话号码";

  static const String login_ch = "登录";

  static const String logout_ch = "退出登录";

  static const String register_ch = "注册";

  static const String user_term_ch = "用户协议";
  static const String user_term_confirm_ch =
      "同意《鸿雁骑行用户协议》，并授权鸿雁骑行使用您的账号信息，进行统一管理。";

  static final List<InlineSpan> forgot_password_link_richtext = [
    TextSpan(
        text: '忘记密码',
        style: TextStyle(
            color: ColorHelper.primary,
            decoration: TextDecoration.underline,
            fontSize: 12)),
  ];

  static final List<InlineSpan> register_link_richtext = [
    TextSpan(
        text: '没有账号？去',
        style: TextStyle(color: Colors.grey, fontSize: 12)),
    TextSpan(
        text: '注册',
        style: TextStyle(
            color: ColorHelper.primary,
            decoration: TextDecoration.underline,
            fontSize: 12)),
  ];
}
