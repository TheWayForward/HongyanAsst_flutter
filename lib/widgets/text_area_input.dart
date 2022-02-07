import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/utils/color_helper.dart';
import 'package:hongyanasst/utils/message_helper.dart';
import 'package:hongyanasst/utils/tag_helper.dart';
import 'package:hongyanasst/widgets/common_dialog.dart';

class TextAreaInput extends StatefulWidget {
  final List<TextInputFormatter> inputFormatters;
  final int maxLength;
  final bool enabled;
  final String hint;
  final String content;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> focusChanged;
  final TextInputType keyboardType;

  const TextAreaInput(
      {Key? key,
      required this.inputFormatters,
      required this.maxLength,
      this.enabled = true,
      required this.hint,
      required this.content,
      required this.onChanged,
      required this.focusChanged,
      required this.keyboardType})
      : super(key: key);

  @override
  _TextAreaInputState createState() => _TextAreaInputState();
}

class _TextAreaInputState extends State<TextAreaInput> {
  final _focusNode = FocusNode();
  TextEditingController? _textEditingController;
  String _helperText = "";
  String _counter = "";

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.content);
    setState(() {
      _counter = "${widget.content.length}/${widget.maxLength}";
    });
    _textEditingController!.addListener(() {
      _counter = "${_textEditingController!.text.length}/${widget.maxLength}";
    });
    _focusNode.addListener(() {
      print("Has Focus: ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged(_focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      child: TextField(
        controller: _textEditingController,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        inputFormatters: widget.inputFormatters,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        textAlignVertical: TextAlignVertical.top,
        expands: true,
        maxLines: null,
        minLines: null,
        autofocus: true,
        cursorColor: ColorHelper.primary,
        style: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
        decoration: InputDecoration(
            counter: Text(_counter),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffB6B6B6), width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2)),
            focusColor: ColorHelper.primary,
            helperText: _helperText,
            contentPadding:
                EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            labelText: widget.hint,
            labelStyle: TextStyle(color: ColorHelper.primary),
            border: OutlineInputBorder(),
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
            suffixIcon: IconButton(
                onPressed: _clearText,
                icon: Icon(Icons.close, color: Colors.grey))),
      ),
    );
  }

  _clearText() async {
    FocusScope.of(context).unfocus();
    var result = await commonDialog(context,
        title: TagHelper.notice_ch, message: MessageHelper.text_clear_ask);
    if (result == OkCancelResult.ok) {
      setState(() {
        _textEditingController!.clear();
        _counter = "0/${widget.maxLength}";
      });
    }
  }
}
