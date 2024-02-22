import 'package:flutter/material.dart';
import 'package:swp_project_web/theme/pallete.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const LoginField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        const Icon(Icons.person, color: Color.fromARGB(255, 224, 48, 74)),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.25,
            ),
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              decoration: InputDecoration(
                labelText: 'Tài khoản',
                labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 43, 42, 53),
                ),
                contentPadding: EdgeInsets.all(screenHeight * 0.025),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 13, 10, 56),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Pallete.gradient3,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hintText,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 28, 27, 27)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
