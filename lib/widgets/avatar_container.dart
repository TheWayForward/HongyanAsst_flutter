import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/view_helper.dart';

class AvatarContainer extends StatelessWidget {

  final String avatar;
  final bool isTitle;
  const AvatarContainer({Key? key, required this.avatar, this.isTitle = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isTitle ? Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white54, width: 3)),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(38),
          child: ViewHelper.cachedImage(avatar, true, width: 76, height: 76),
        )) : Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white54, width: 3)),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(14),
          child: ViewHelper.cachedImage(avatar, true, width: 28, height: 28),
        ));
  }
}
