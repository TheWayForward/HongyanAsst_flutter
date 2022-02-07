import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bot_toast/bot_toast.dart';

class ShowToast {

  static void showToast(String text, BuildContext context) {
    BotToast.showText(text: text);
  }

  // static void showWarnToast(String text) {
  //   Fluttertoast.showToast(
  //       msg: text,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white);
  // }
  //
  // static void showToast(String text) {
  //   Fluttertoast.showToast(
  //     msg: text,
  //     backgroundColor: Colors.grey,
  //     textColor: Colors.white,
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.SNACKBAR,
  //   );
  // }
}

