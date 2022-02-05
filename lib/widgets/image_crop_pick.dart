import 'package:flutter/material.dart';
import 'package:hongyanasst/navigator/hi_navigator.dart';
import 'dart:io';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'hi_bottom_sheet.dart';

// only for single image
imageCropPick(BuildContext context) {
  HiBottomSheet.showOption(context,
      data: [TagHelper.image_from_camera, TagHelper.image_from_gallery],
      title: TagHelper.change_avatar_ch,
      onTap: (int index, String data) {
        switch(index) {
          case 0:
            _getImage(true, context);
            break;
          case 1:
            _getImage(false, context);
            break;
        }
      });
}

Future _getImage(bool isTakePhoto, BuildContext context) async {
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
