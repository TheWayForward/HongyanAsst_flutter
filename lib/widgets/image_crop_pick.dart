import 'package:flutter/material.dart';
import 'package:hongyanasst/navigator/hi_navigator.dart';
import 'dart:io';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:image_picker/image_picker.dart';

// only for single image

class ImageCropPick extends StatefulWidget {
  const ImageCropPick({Key? key}) : super(key: key);

  @override
  _ImageCropPickState createState() => _ImageCropPickState();
}

class _ImageCropPickState extends State<ImageCropPick> {
  final List<XFile> _images = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _genImages(),
        ),
        SizedBox(height: 20),
        ElevatedButton(onPressed: _pickImage, child: Text("pick image"))
      ],
    );
  }

  _pickImage() {
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
                  _item(TagHelper.image_from_camera, true),
                  Divider(),
                  _item(TagHelper.image_from_gallery, false),
                ],
              ),
            ));
  }

  _title() {
    return ListTile(
        title: Text(TagHelper.change_avatar_ch,
            style: TextStyle(
                color: ColorHelper.primary, fontWeight: FontWeight.bold)));
  }

  _item(String title, bool isTakePhoto) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isTakePhoto),
      ),
    );
  }

  Future getImage(bool isTakePhoto) async {
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

  _genImages() {
    return _images.map((file) {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(File(file.path),
                width: 120, height: 90, fit: BoxFit.fill),
          ),
          Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _images.remove(file);
                  });
                },
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(color: Colors.black54),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
        ],
      );
    }).toList();
  }
}
