import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final double widthInput;
  final String? content;
  const InputField({
    Key? key,
    this.hintText,
    required this.controller,
    required this.widthInput,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 5),
          child: TextContent(
            contentText: content ?? "",
            color: Colors.black,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth * widthInput,
          ),
          child: TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            decoration: InputDecoration(
              labelText: hintText,
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 159, 159, 159),
              ),
              contentPadding: EdgeInsets.all(screenHeight * 0.025),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 168, 167, 167),
                  width: 1,
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
              hintText: "",
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 28, 27, 27)),
            ),
          ),
        ),
      ],
    );
  }
}
