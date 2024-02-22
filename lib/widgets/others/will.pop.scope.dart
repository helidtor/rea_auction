import 'package:flutter/material.dart';

class WillPS extends StatelessWidget {
  final Widget child;
  const WillPS({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: child,
    );
  }
}
