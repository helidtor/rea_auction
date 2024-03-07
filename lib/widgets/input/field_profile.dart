import 'package:flutter/material.dart';
import 'package:swp_project_web/theme/pallete.dart';

class FieldProfile extends StatefulWidget {
  final String content;
  final bool readOnly;
  final String label;
  final TextEditingController? controller;
  final double widthInput;
  final Function? onChangeText;
  final IconData? icon;
  const FieldProfile({
    Key? key,
    required this.label,
    this.controller,
    required this.widthInput,
    required this.readOnly,
    required this.content,
    this.onChangeText,
    this.icon,
  }) : super(key: key);

  @override
  State<FieldProfile> createState() => _FieldProfileState();
}

class _FieldProfileState extends State<FieldProfile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * widget.widthInput,
              maxHeight: 45,
            ),
            child: TextFormField(
              initialValue: widget.content,
              readOnly: widget.readOnly,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
              decoration: InputDecoration(
                //tiêu đề////////////////
                labelText: widget.label,
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 219, 84, 104)
                        .withOpacity(0.7),
                    fontSize: 18),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(168, 167, 167, 0.344),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Pallete.gradient3,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "",
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 28, 27, 27)),
                prefixIcon: widget.icon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(widget.icon,
                            color: Pallete.gradient3, size: 30),
                      )
                    : null,
              ),
              onChanged: (text) {
                widget.onChangeText!(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
