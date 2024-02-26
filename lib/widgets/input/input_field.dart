import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';

class InputField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final double widthInput;
  final double? heightInput;
  final String? content;
  final Function? onChangeText;
  const InputField({
    Key? key,
    this.hintText,
    required this.controller,
    required this.widthInput,
    this.content,
    this.heightInput,
    this.onChangeText,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double? height;
    height = widget.heightInput;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 5),
          child: TextContent(
            contentText: widget.content ?? "",
            color: Colors.black,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth * widget.widthInput,
          ),
          child: TextFormField(
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.top,
            minLines: 1,
            maxLines: null,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 159, 159, 159),
              ),
              contentPadding: EdgeInsets.all((height != null) ? height : 15),
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
            onChanged: (text) {
              widget.onChangeText!(text);
            },
          ),
        ),
      ],
    );
  }
}
