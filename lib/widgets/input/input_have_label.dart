import 'package:flutter/material.dart';
import 'package:swp_project_web/theme/pallete.dart';

class InputHaveLabel extends StatefulWidget {
  final String labelText;
  final String? initialText;
  final Function? onChangeText;
  final Function()? onTap;
  final bool? readOnly;
  const InputHaveLabel(
      {super.key,
      required this.labelText,
      this.initialText,
      this.onChangeText,
      this.readOnly,
      this.onTap});

  @override
  State<InputHaveLabel> createState() => _InputHaveLabelState();
}

class _InputHaveLabelState extends State<InputHaveLabel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6)),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            onTap: widget.onTap ?? () {},
            readOnly: widget.readOnly ?? false,
            maxLines: null,
            minLines: null,
            initialValue: widget.initialText,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hoverColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(168, 167, 167, 0.344),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Pallete.gradient3.withOpacity(0.5),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (text) {
              widget.onChangeText!(text);
            },
          ),
        ],
      ),
    );
  }
}
