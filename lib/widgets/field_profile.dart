import 'package:flutter/material.dart';

class FieldProfile extends StatefulWidget {
  final String content;
  final bool readOnly;
  final String? label;
  final TextEditingController? controller;
  final double widthInput;
  final Function? onChangeText;
  final IconData? icon;
  const FieldProfile({
    Key? key,
    this.label,
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
              maxHeight: 65,
            ),
            child: TextFormField(
              initialValue: widget.content,
              readOnly: widget.readOnly,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
              decoration: InputDecoration(
                //tiêu đề////////////////
                labelText: widget.label,
                labelStyle: const TextStyle(
                    color: Color.fromARGB(208, 110, 77, 202), fontSize: 20),
                contentPadding: const EdgeInsets.all(22),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(168, 167, 167, 0.344),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: "",
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 28, 27, 27)),
                prefixIcon: widget.icon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Icon(widget.icon, color: Colors.black, size: 30),
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
