import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';

class HiCityPicker {
  static showCityPicker(BuildContext context) async{
    var result = await CityPickers.showCityPicker(context: context);
    return result;
  }
}