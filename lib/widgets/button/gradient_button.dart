// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final String s;
  final double widthButton;
  const GradientButton(
      {super.key,
      required this.s,
      required this.widthButton,
      Null Function()? onTap});

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  late String s;
  late double widthButton;

  @override
  void initState() {
    s = widget.s;
    widthButton = widget.widthButton;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 226, 20, 51),
            Color.fromARGB(255, 213, 65, 87),
            Color.fromARGB(255, 229, 135, 149),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          width: screenWidth * widthButton,
          height: screenHeight * 0.07,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              s,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
