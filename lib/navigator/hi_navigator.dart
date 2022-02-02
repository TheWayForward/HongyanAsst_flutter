import 'package:flutter/material.dart';
import 'package:hongyanasst/navigator/bottom_navigator.dart';
import 'package:hongyanasst/pages/login_page.dart';
import 'package:hongyanasst/pages/registration_page.dart';
import 'package:url_launcher/url_launcher.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo pre);

// build page
pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}

// get the position of routeStatus in page stack
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

enum RouteStatus { login, registration, home, profile, unknown }

RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else {
    return RouteStatus.unknown;
  }
}

class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

// page jump listener
class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;
  RouteJumpListener? _routeJump;

  // page list in this app
  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;

  // bottom navigator at home page
  RouteStatusInfo? _bottomTab;

  // singleton
  HiNavigator._();

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance!;
  }

  RouteStatusInfo? getCurrent() {
    return _current;
  }

  Future<bool> openH5(String url) async {
    var result = await canLaunch(url);
    if (result) {
      return await launch(url);
    } else {
      return Future.value(false);
    }
  }

  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  // tab switch listener
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  // notify route page change
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) {
      return;
    }
    // current page info, at top
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      // bottom tab opened
      current = _bottomTab!;
    }

    print("hi_navigator-current: ${current.page}");
    print("hi_navigator-pre: ${_current?.page}");
    _listeners.forEach((listener) {
      // current as current, _current as pre
      listener(current, _current!);
    });
    _current = current;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    // TODO: implement onJumpTo
    _routeJump!.onJumpTo!(routeStatus, args: args!);
  }
}

abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map args});

class RouteJumpListener {
  final OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
