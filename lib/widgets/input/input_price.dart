import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';

class InputPrice extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final double widthInput;
  final double? heightInput;
  final String? content;
  final Function? onChangeText;
  const InputPrice({
    Key? key,
    this.hintText,
    required this.controller,
    required this.widthInput,
    this.content,
    this.heightInput,
    this.onChangeText,
  }) : super(key: key);

  @override
  State<InputPrice> createState() => _InputPriceState();
}

class _InputPriceState extends State<InputPrice> {
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final controller = widget.controller;
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
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.top,
            minLines: 1,
            maxLines: null,
            style:
                TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 17),
            decoration: InputDecoration(
              suffixText: 'VNĐ',
              suffixStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontSize: 17,
              ),
              labelText: widget.hintText,
              labelStyle: TextStyle(
                fontFamily: GoogleFonts.nunito().fontFamily,
                color: Colors.black.withOpacity(0.5),
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
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "",
              hintStyle: TextStyle(
                color: Colors.grey[350],
                fontSize: 12,
                fontFamily: GoogleFonts.nunito().fontFamily,
              ),
            ),
            onChanged: (text) {
              text = _formatNumber(text.replaceAll(',', ''));
              controller.value = TextEditingValue(
                text: text,
                selection: TextSelection.collapsed(offset: text.length),
              );
              widget.onChangeText!(text);
            },
          ),
        ),
      ],
    );
  }
}
