import 'package:flutter/material.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';

class SingleCheckbox extends StatefulWidget {
  final bool value;
  final String content;
  final void Function(bool?) onChanged;
  final VoidCallback onTextTap;

  const SingleCheckbox(
      {Key? key, this.value = false,
        required this.onChanged,
      required this.content,
      required this.onTextTap})
      : super(key: key);

  @override
  _SingleCheckboxState createState() => _SingleCheckboxState();
}

class _SingleCheckboxState extends State<SingleCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          activeColor: ColorHelper.primary,
          onChanged: widget.onChanged,
          value: widget.value,
        ),
        Expanded(
            child: Container(
          height: 50,
          child: GestureDetector(
              onTap: widget.onTextTap,
              child: Center(
                  child: Text(
                widget.content,
                style: TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.clip,
                    color: Colors.grey),
              ))),
        ))
      ],
    );
  }
}
