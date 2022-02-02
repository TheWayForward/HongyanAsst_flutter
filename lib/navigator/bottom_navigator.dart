import 'package:flutter/material.dart';
import 'package:hongyanasst/pages/home_page.dart';
import 'package:hongyanasst/pages/profile_page.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'hi_navigator.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = ColorHelper.primary;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);
  List<Widget> _pages = [];

  // initial build if false
  bool _hasBuild = false;
  static int initialPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    _pages = [HomePage(), ProfilePage()];
    if (!_hasBuild) {
      // initial build
      HiNavigator.getInstance()
          .onBottomTabChange(initialPageIndex, _pages[initialPageIndex]);
      // initial built
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
        controller: _controller,
        children: [HomePage(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTo(index),
        selectedItemColor: _activeColor,
        items: [
          _bottomItem(TagHelper.bottom_navigation_homepage_ch, Icons.home, 0),
          _bottomItem(TagHelper.bottom_navigation_profilepage_ch, Icons.account_circle, 1)
        ],
      ),
    );
  }

  _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      // from onTap
      _controller.jumpToPage(index);
    } else {
      HiNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      _currentIndex = index;
    });
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, size: 18, color: _defaultColor),
        activeIcon: Icon(icon, size: 18, color: _activeColor),
        label: title);
  }
}
