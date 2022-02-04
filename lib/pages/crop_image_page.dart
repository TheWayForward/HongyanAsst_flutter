import 'package:flutter/material.dart';
import 'package:hongyanasst/dao/upload_dao.dart';
import 'package:hongyanasst/http/core/hi_error.dart';
import 'package:hongyanasst/navigator/hi_navigator.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/message_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/widgets/large_button.dart';
import 'package:hongyanasst/widgets/loading_mask.dart';
import 'package:hongyanasst/widgets/toast.dart';
import 'package:image_crop/image_crop.dart';
import 'dart:io';

class CropImagePage extends StatefulWidget {
  final File image;

  const CropImagePage({Key? key, required this.image}) : super(key: key);

  @override
  _CropImagePageState createState() => _CropImagePageState();
}

class _CropImagePageState extends State<CropImagePage> {
  double baseLeft = 100;
  double baseTop = 100;
  double imageWidth = 400;
  double imageScale = 1;
  Image? imageView;
  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Crop.file(
              widget.image,
              key: cropKey,
              // square aspect ratio
              aspectRatio: 1.0,
              alwaysShowGrid: true,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(width: 4.5),
            Expanded(
                child: LargeButton(TagHelper.cancel_ch,
                    color: Colors.grey, onPressed: _back)),
            SizedBox(width: 10),
            Expanded(
                child: LargeButton(TagHelper.confirm_ch, onPressed: _crop)),
            SizedBox(width: 4.5),
          ])
        ],
      ),
    ));
  }

  _back() {
    Navigator.of(context).pop();
  }

  _crop() {
    __crop();
  }

  Future<void> __crop() async {
    final scale = cropKey.currentState!.scale;
    final area = cropKey.currentState!.area;
    if (area == null) {
      return;
    }
    final sample = await ImageCrop.sampleImage(
      file: widget.image,
      preferredSize: (2000 / scale).round(),
    );
    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );
    sample.delete();
    _upload(file);
  }

  _upload(File file) async {
    LoadingMask.showLoading(MessageHelper.loading_indication_ch);
    try {
      var result = await UploadDao.uploadAvatar("1", file.path);
      print(result);
      LoadingMask.dismiss();
      ShowToast.showToast(MessageHelper.upload_succeed_ch);
      Navigator.of(context).pop();
    } on NoContent catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showInfo(e.message);
      print(e.toString());
    } on NeedAuth catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showInfo(MessageHelper.request_unauth_ch);
      print(e.toString());
    } on NeedLogin catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showInfo(e.message);
      print(e.toString());
    } on HiNetError catch (e) {
      LoadingMask.dismiss();
      LoadingMask.showError(MessageHelper.internal_error_ch);
    }
  }
}
