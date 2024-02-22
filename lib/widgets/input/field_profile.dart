import 'package:flutter/material.dart';
import 'package:swp_project_web/theme/pallete.dart';

class FieldProfile extends StatefulWidget {
  final String content;
  final bool readOnly;
  final String label;
  final TextEditingController controller;
  final double widthInput;
  final Function? onChangeText;
  const FieldProfile({
    Key? key,
    required this.label,
    required this.controller,
    required this.widthInput,
    required this.readOnly,
    required this.content,
    this.onChangeText,
  }) : super(key: key);

  @override
  State<FieldProfile> createState() => _FieldProfileState();
}

class _FieldProfileState extends State<FieldProfile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 5),
          child: Text(
            widget.label,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth * widget.widthInput,
          ),
          child: TextFormField(
            initialValue: widget.content,
            readOnly: widget.readOnly,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            decoration: InputDecoration(
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
            onChanged: (text) {
              widget.onChangeText!(text);
            },
          ),
        ),
      ],
    );
  }
}
