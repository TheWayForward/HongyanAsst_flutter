import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/models/user_model.dart';
import 'package:hongyanasst/pages/crop_image_page.dart';
import 'package:hongyanasst/pages/login_page.dart';
import 'package:hongyanasst/pages/profile_edit_page.dart';
import 'package:hongyanasst/pages/registration_page.dart';
import 'package:hongyanasst/pages/retrieve_password_page.dart';
import 'package:hongyanasst/pages/user_term_page.dart';
import 'package:hongyanasst/provider/hi_provider.dart';
import 'package:hongyanasst/provider/theme_provider.dart';
import 'package:hongyanasst/utils/message_helper.dart';
import 'package:hongyanasst/widgets/splash_screen.dart';
import 'package:hongyanasst/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'dao/login_dao.dart';
import 'db/hi_cache.dart';
import 'http/core/hi_net.dart';
import 'navigator/bottom_navigator.dart';
import 'navigator/hi_navigator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouteDelegate _routerDelegate = AppRouteDelegate();
  AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    print('_AppState:build');
    var widget;
    return FutureBuilder<HiCache>(
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
                builder: EasyLoading.init(),
                debugShowCheckedModeBanner: false,
                home: Splash());
          } else if (snapshot.connectionState == ConnectionState.done) {
            widget = Router(routerDelegate: _routerDelegate);
          } else {
            widget = Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
          return MultiProvider(
            providers: topProviders,
            child: Consumer<ThemeProvider>(builder:
                (BuildContext context, ThemeProvider value, Widget? child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeProvider().getTheme(),
                darkTheme: ThemeProvider().getTheme(isDarkMode: true),
                themeMode: ThemeProvider().getThemeMode(),
                home: widget,
                builder: EasyLoading.init(),
                title: "HongyanAsst",
              );
            }),
          );
        });
    // return MaterialApp(home: widget);
  }
}

class AppRouteDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  RouteStatus _routeStatus = RouteStatus.home;
  AppRoutePath? path;

  List<MaterialPage> pages = [];

  File? tempImage;
  UserModel? userModel;

  // set a key for navigator, get NavigatorState by navigatorKey.currentState
  AppRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      notifyListeners();
      if (routeStatus == RouteStatus.crop_image) {
        this.tempImage = args!["tempImage"];
        notifyListeners();
      }
      if (_routeStatus == RouteStatus.profile_edit) {
        this.userModel = args!["userModel"];
        notifyListeners();
      }

      // if (routeStatus == ...) then ... notifyListeners(); (interceptor: message channel between pages)
    }));

    // network error interceptor
    HiNet.getInstance().setErrorInterceptor((error) {
      if (error is NeedLogin) {
        HiCache.getInstance().remove(LoginDao.BOARDING_PASS);
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      }
    });
  }

  bool get hasLogin =>
      LoginDao.getBoardingPass() != null &&
      LoginDao.getBoardingPass().length != 0;

  RouteStatus get routeStatus {
    // cancel the note below and rerun the app when you need to force logout
    // LoginDao.deleteBoardingPass();

    // interceptor, user can only login, read terms or retrieve password without login

    // mock login
    // return _routeStatus;

    if (_routeStatus != RouteStatus.registration &&
        _routeStatus != RouteStatus.user_term &&
        _routeStatus != RouteStatus.retrieve_password &&
        !hasLogin) {
      // must login to proceed
      return _routeStatus = RouteStatus.login;
    } else {
      return _routeStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // current stack contains target page
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      // all page pop stack except of homepage
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.profile_edit) {
      print("edit");
      page = pageWrap(ProfileEditPage(userModel: userModel!));
    } else if (routeStatus == RouteStatus.crop_image) {
      page = pageWrap(CropImagePage(image: tempImage!));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    } else if (routeStatus == RouteStatus.user_term) {
      page = pageWrap(UserTermPage());
    } else if (routeStatus == RouteStatus.retrieve_password) {
      page = pageWrap(RetrievePasswordPage());
    }
    print(page);
    tempPages = [...tempPages, page];
    // tempPages as current, pages as old
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;

    print("Page router contains ${pages.length} page(s).");

    // fix android back button problem
    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            if (route.settings is MaterialPage) {
              // login page interceptor
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  ShowToast.showWarnToast(MessageHelper.login_indication_ch);
                  return false;
                }
              }
            }

            if (!route.didPop(result)) {
              return false;
            }
            var tempPages = [...pages];
            pages.removeLast();
            // pages as current, tempPages as old
            HiNavigator.getInstance().notify(pages, tempPages);
            return true;
          },
        ),
        // back button pop page
        onWillPop: () async => !await navigatorKey.currentState!.maybePop());
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {}
}

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    print('AppRouteInformationParser:parseRouteInformation:uri: $uri');
    if (uri.pathSegments.length == 0) {
      return AppRoutePath.home();
    }
    return AppRoutePath.detail();
  }
}

class AppRoutePath {
  final String location;

  AppRoutePath.home() : location = "/";

  AppRoutePath.detail() : location = "/detail";
}

pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}
