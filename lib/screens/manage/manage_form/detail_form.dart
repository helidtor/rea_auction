import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swp_project_web/models/response/form_model.dart';

class DetailForm extends StatefulWidget {
  final FormsModel? formModel;
  const DetailForm({super.key, this.formModel});

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  late FormsModel formModel;
  @override
  Widget build(BuildContext context) {
    if (widget.formModel != null) {
      formModel = widget.formModel!;
    }
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 500,
            height: 350,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(253, 255, 255, 255),
              ),
              color: const Color.fromARGB(253, 255, 255, 255),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: (formModel.propertyImages!.isEmpty)
                    ? const AssetImage("assets/images/error_load_image.jpg")
                    : Image.network(formModel.propertyImages!.first).image,
              ),
            ),
          ),
          SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Tiêu đề:',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      formModel.title ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
