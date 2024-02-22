// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:swp_project_web/theme/pallete.dart';

class SelectionAppBarButton extends StatelessWidget {
  final String text;
  final Widget navigatePage;

  const SelectionAppBarButton({
    Key? key,
    required this.text,
    required this.navigatePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => navigatePage));
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ));
  }
}
