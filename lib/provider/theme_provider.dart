import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hongyanasst/db/hi_cache.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/config_helper.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;
  var _platformBrightness =
      SchedulerBinding.instance?.window.platformBrightness;

  void darModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance?.window.platformBrightness) {
      _platformBrightness =
          SchedulerBinding.instance?.window.platformBrightness;
      notifyListeners();
    }
  }

  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      // get system mode
      return SchedulerBinding.instance?.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  ThemeMode getThemeMode() {
    String? theme = HiCache.getInstance().get(ConfigHelper.theme);
    switch (theme) {
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'System':
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode!;
  }

  void setTheme(ThemeMode themeMode) {
    HiCache.getInstance().setString(ConfigHelper.theme, themeMode.value);
    notifyListeners();
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        errorColor: isDarkMode ? ColorHelper.dark_red : ColorHelper.red,
        primaryColor: isDarkMode ? ColorHelper.dark_bg : ColorHelper.white,
        accentColor: isDarkMode ? ColorHelper.primary : ColorHelper.white,
        indicatorColor: isDarkMode ? ColorHelper.primary : ColorHelper.primary,
        scaffoldBackgroundColor:
            isDarkMode ? ColorHelper.dark_bg : ColorHelper.white);
    return themeData;
  }
}
