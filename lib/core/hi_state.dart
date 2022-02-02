import 'package:flutter/cupertino.dart';

// abstract class for hi_base_tab_state

abstract class HiState<T extends StatefulWidget> extends State<T>{
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print("HiState: page disposed, no setState in ${toString()}");
    }
  }
}