import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swp_project_web/models/response/form_model.dart';
import 'package:swp_project_web/screens/manage/manage_form/bloc/form_bloc.dart';
import 'package:swp_project_web/screens/manage/manage_form/bloc/form_event.dart';

import 'package:swp_project_web/screens/manage/manage_form/bloc/form_state.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/notification/toast.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class DetailForm extends StatefulWidget {
  final FormsModel? formModel;
  const DetailForm({super.key, this.formModel});

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  late FormsModel formModel;
  final _bloc = FormBloc();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isApprove = false;
    if (widget.formModel != null) {
      formModel = widget.formModel!;
    }
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: BlocConsumer<FormBloc, FormStates>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is FormLoading) {
            onLoading(context);
            return;
          } else if (state is ApproveFormSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
            toastification.show(
                pauseOnHover: false,
                progressBarTheme: const ProgressIndicatorThemeData(
                  color: Colors.green,
                ),
                icon: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                foregroundColor: Colors.black,
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.minimal,
                title: const TextContent(
                  contentText: "Phê duyệt thành công",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                autoCloseDuration: const Duration(milliseconds: 1500),
                animationDuration: const Duration(milliseconds: 500),
                alignment: Alignment.topRight);
          } else if (state is FormError) {
            showToast(
              context: context,
              msg: state.error,
              color: Colors.orange,
              icon: const Icon(Icons.warning, color: Colors.white),
              colorText: Colors.white,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 250),
            child: Container(
              width: screenWidth * 0.75,
              height: screenHeight * 0.8,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(253, 255, 255, 255),
                  ),
                  color: const Color.fromARGB(253, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screenWidth * 0.4,
                    height: 450,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(253, 255, 255, 255),
                      ),
                      color: const Color.fromARGB(253, 255, 255, 255),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: (formModel.propertyImages!.isEmpty)
                            ? const AssetImage(
                                "assets/images/error_load_image.jpg")
                            : Image.network(formModel.propertyImages!.first)
                                .image,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: screenWidth * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'ID:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  formModel.id.toString() ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Tiêu đề:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  formModel.title ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Ngày tạo đơn:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  (formModel.createdAt != null)
                                      ? DateFormat("dd-MM-yyyy hh:mm:ss")
                                          .format(DateTime.parse(
                                              formModel.createdAt!))
                                      : "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Địa chỉ:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  formModel.propertyWard != null
                                      ? '${formModel.propertyStreet}, ${formModel.propertyWard}, ${formModel.propertyDistrict}, ${formModel.propertyCity}'
                                      : '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Diện tích:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${formModel.propertyArea.toString()}m\u00b2' ??
                                      "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Giá khởi điểm:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  formModel.propertyArea.toString() ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Chủ sở hữu:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${formModel.author!.firstName} ${formModel.author!.lastName}' ??
                                      "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Trạng thái:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  convertStatus(formModel.postStatus),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                const Text(
                                  'Nội dung:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  formModel.content ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100, top: 200),
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      _bloc.add(ApproveForm(id: formModel.id!));
                                    },
                                    child: Container(
                                      width: 120,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green),
                                      child: const Center(
                                        child: Text(
                                          'Phê duyệt',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      width: 120,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red),
                                      child: const Center(
                                        child: Text(
                                          'Từ chối',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String convertStatus(int? postStatus) {
    switch (postStatus) {
      case 1:
        return 'Đợi duyệt';
      case 2:
        return 'Từ chối';
      case 3:
        return 'Đã duyệt';
      case 4:
        return 'Hoàn tất';
      default:
        return '';
    }
  }
}
