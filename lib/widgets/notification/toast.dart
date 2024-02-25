import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget extends StatelessWidget {
  final Color color;
  final Color? colorText;
  final Icon icon;
  final String msg;
  const ToastWidget({
    Key? key,
    required this.msg,
    required this.color,
    required this.icon,
    required this.colorText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: Color.fromARGB(0, 255, 129, 129)),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(
            width: 12.0,
          ),
          Text(msg,
              style: TextStyle(color: colorText, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

void showToast(
    {required BuildContext context,
    required String msg,
    required Color color,
    required Color? colorText,
    required Icon icon,
    final double? top,
    final double? right,
    int? timeHint}) {
  FToast fToast = FToast();
  fToast.init(context);
  return fToast.showToast(
      child: ToastWidget(
        msg: msg,
        color: color,
        icon: icon,
        colorText: colorText,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: timeHint ?? 4),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: top ?? 18.0,
          right: right ?? 20.0,
          child: child,
        );
      });
}
