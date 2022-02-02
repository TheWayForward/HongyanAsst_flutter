import 'package:flutter/material.dart';

class Href extends StatelessWidget {
  final List<InlineSpan> inlineSpanList;
  final VoidCallback onTapLink;

  const Href({Key? key, required this.inlineSpanList, required this.onTapLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapLink,
      child: Center(
        child: RichText(
          text: TextSpan(text: "", children: inlineSpanList),
        ),
      ),
    );
  }
}
