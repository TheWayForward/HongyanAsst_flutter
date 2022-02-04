import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hongyanasst/utils/color_helper.dart';

class CommonInput extends StatefulWidget {
  final List<TextInputFormatter> inputFormatters;
  final String hint;
  final String helperText;
  final bool enabled;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  _CommonInputState createState() => _CommonInputState();

  CommonInput(
      {this.inputFormatters = const [],
      required this.hint,
      required this.helperText,
      required this.onChanged,
      required this.focusChanged,
      this.enabled = true,
      this.maxLength = 20,
      this.lineStretch = false,
      this.obscureText = false,
      required this.keyboardType});
}

class _CommonInputState extends State<CommonInput> {
  final _focusNode = FocusNode();
  bool _obsureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      print("Has Focus: ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged(_focusNode.hasFocus);
      }
      _obsureText = widget.obscureText;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_input()],
    );
  }

  Widget _input() {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextField(
          enabled: widget.enabled,
          inputFormatters: widget.inputFormatters,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          obscureText: _obsureText,
          keyboardType: widget.keyboardType,
          autofocus: !widget.obscureText,
          cursorColor: ColorHelper.primary,
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obsureText = !_obsureText;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye_outlined,
                          color:
                              _obsureText ? Colors.grey : ColorHelper.primary))
                  : Icon(Icons.done, size: 0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffB6B6B6), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2)),
              focusColor: ColorHelper.primary,
              helperText: widget.helperText,
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              labelText: widget.hint,
              labelStyle: TextStyle(color: ColorHelper.primary),
              border: OutlineInputBorder(),
              hintText: widget.hint,
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
        ));
  }
}
