import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/color_helper.dart';

class LargeButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LargeButton(this.title, {Key? key, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: ColorHelper.primary[50],
        color: ColorHelper.primary,
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}