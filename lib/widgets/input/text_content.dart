import 'package:flutter/material.dart';
import 'package:swp_project_web/theme/pallete.dart';

class TextContent extends StatelessWidget {
  final String contentText;
  final Color? color;
  final FontWeight? fontWeight;
  final int? fontSize;

  const TextContent(
      {super.key, required this.contentText, this.color, this.fontWeight, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      contentText,
      style: TextStyle(
        color: color ?? const Color.fromARGB(255, 255, 255, 255),
        fontSize: 15,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
