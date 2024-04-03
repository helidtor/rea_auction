import 'package:flutter/material.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';

class ContactInfor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TopBar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      ),
      body: const Text('Coming soon'),
    );
  }
}
