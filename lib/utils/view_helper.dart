import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/http/request/base_request.dart';
import 'package:provider/provider.dart';

import 'config_helper.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class ViewHelper {
  static Widget cachedImage(String url, bool relative,
      {double? width, double? height}) {
    if (relative) {
      url = "${ConfigHelper.getAuthority(useHttps: false)}${url}";
    }
    return CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (
          BuildContext context,
          String url,
        ) =>
            Container(color: Colors.grey[200]),
        errorWidget: (
          BuildContext context,
          String url,
          dynamic error,
        ) =>
            Icon(Icons.error),
        imageUrl: url);
  }

  static void changeStatusBar(
      {color: Colors.white,
      StatusStyle statusStyle: StatusStyle.DARK_CONTENT,
      BuildContext? context}) {
    var brightness;
    if (Platform.isIOS) {
      brightness = statusStyle == StatusStyle.LIGHT_CONTENT
          ? Brightness.dark
          : Brightness.light;
    } else {
      brightness = statusStyle == StatusStyle.LIGHT_CONTENT
          ? Brightness.light
          : Brightness.dark;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));
  }

  static blackLinearGradient({bool fromTop = false}) {
    return LinearGradient(
        colors: [
          Colors.black54,
          Colors.black45,
          Colors.black38,
          Colors.black26,
          Colors.transparent
        ],
        begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
        end: fromTop ? Alignment.bottomCenter : Alignment.topCenter);
  }

  static borderLine(BuildContext context, {bottom: true, top: false}) {
    var lineColor = Colors.grey;
    BorderSide borderSide = BorderSide(width: 0.5, color: lineColor);
    return Border(
        bottom: bottom ? borderSide : BorderSide.none,
        top: top ? borderSide : BorderSide.none);
  }

  static BoxShadow bottomBoxShadow(BuildContext context) {
    return BoxShadow(
        color: Colors.grey[100]!,
        offset: Offset(0, 5),
        blurRadius: 1.0,
        spreadRadius: 1);
  }
}
