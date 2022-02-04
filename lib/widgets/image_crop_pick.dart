import 'package:flutter/material.dart';
import 'package:hongyanasst/navigator/hi_navigator.dart';
import 'dart:io';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:image_picker/image_picker.dart';

// only for single image
pickImage(BuildContext context) {
  showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (context) => Container(
        height: 220,
        child: ListView(
          children: <Widget>[
            _title(),
            Divider(),
            _item(TagHelper.image_from_camera, true, context),
            Divider(),
            _item(TagHelper.image_from_gallery, false, context),
          ],
        ),
      ));

}

_title() {
  return ListTile(
    leading: Icon(Icons.settings_applications),
      title: Text(TagHelper.change_avatar_ch,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18)));
}

_item(String title, bool isTakePhoto, BuildContext context) {
  return GestureDetector(
    child: ListTile(
      leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
      title: Text(title),
      onTap: () => getImage(isTakePhoto, context),
    ),
  );
}

Future getImage(bool isTakePhoto, BuildContext context) async {
  Navigator.pop(context);
  var image = await ImagePicker()
      .pickImage(
      source: isTakePhoto ? ImageSource.camera : ImageSource.gallery)
      .then((image) {
    // convert XFile to File
    if (image != null) {
      File convertedFile = File(image.path);
      HiNavigator.getInstance().onJumpTo(RouteStatus.crop_image,
          args: {"tempImage": convertedFile});
    }
  });
}
