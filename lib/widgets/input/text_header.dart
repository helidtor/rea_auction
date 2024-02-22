import 'package:flutter/material.dart';
import 'package:swp_project_web/theme/pallete.dart';

class TextHeader extends StatelessWidget {
  final String contentText;

  const TextHeader({super.key, required this.contentText});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Text(
      contentText,
      style: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 28,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
