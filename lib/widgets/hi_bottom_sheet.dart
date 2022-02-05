import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';

typedef ClickCallback = void Function(int selectIndex, String selectString);

class HiBottomSheet {
  static void showOption(BuildContext context,
      {required List<String> data,
      required String title,
      bool showDestructive = false,
      required ClickCallback onTap}) {
    double titleHeight = 30;
    double titleLineHeight = 80;
    double fontSize = 16;
    double cellHeight = 30;
    double spaceHeight = 5;
    var textColor;

    if (title == null) {
      titleHeight = 0.0;
      titleLineHeight = 0.0;
    }

    if (showDestructive) {
      textColor = ColorHelper.red;
    }

    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (BuildContext context) {
          return Container(
            height: titleHeight + 40 + titleLineHeight + (cellHeight + 5) * data.length,
            padding: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                // title
                Container(
                    height: titleHeight,
                    child: Center(
                        child: Text(title,
                            style: TextStyle(
                                fontSize: fontSize, color: ColorHelper.red),
                            textAlign: TextAlign.center))),
                Divider(),
                ListView.separated(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: Container(
                            height: cellHeight,
                            color: Colors.white,
                            child: Center(
                                child: Text(data[index],
                                    style: TextStyle(
                                        fontSize: fontSize, color: textColor),
                                    textAlign: TextAlign.center))),
                        onTap: () {
                          onTap(index, data[index]);
                        });
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
                Divider(),
                GestureDetector(
                  child: Container(
                      height: cellHeight,
                      color: Colors.white,
                      child: Center(
                          child: Text(TagHelper.cancel_ch,
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.black),
                              textAlign: TextAlign.center))),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Divider()
              ],
            ),
          );
        });
  }
}
