import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hongyanasst/utils/color_helper.dart';

// must use after EasyLoading.init()

const duration = Duration(milliseconds: 1000);

class LoadingMask {
  static showLoading(String hint) {
    EasyLoading.show(
        status: hint,
        maskType: EasyLoadingMaskType.clear,
        indicator: CircularProgressIndicator(
            color: ColorHelper.primary, backgroundColor: Colors.white54));
  }

  static showInfo(String hint) {
    EasyLoading.showInfo(hint,
        maskType: EasyLoadingMaskType.clear, duration: duration);
  }

  static showSuccess(String hint) {
    EasyLoading.showSuccess(hint,
        maskType: EasyLoadingMaskType.clear, duration: duration);
  }

  static showError(String hint) {
    EasyLoading.showError(hint,
        maskType: EasyLoadingMaskType.clear, duration: duration);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
