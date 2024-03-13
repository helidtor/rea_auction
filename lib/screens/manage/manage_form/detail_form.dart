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
  List<String> listImage = [];
  String selectedImage = "";

  @override
  void initState() {
    super.initState();
    if (widget.formModel != null) {
      formModel = widget.formModel!;
      if (formModel.propertyImages!.isNotEmpty) {
        listImage = formModel.propertyImages!;
        selectedImage = listImage.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
          } else if (state is DeclineFormSuccess) {
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
                  contentText: "Từ chối thành công",
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
          return SingleChildScrollView(
            child: Container(
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
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 30),
                        child: Container(
                          width: screenWidth * 0.4,
                          height: 450,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(253, 255, 255, 255),
                            ),
                            color: const Color.fromARGB(253, 255, 255, 255),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: (selectedImage == "")
                                  ? const AssetImage(
                                      "assets/images/error_load_image.jpg")
                                  : Image.network(selectedImage).image,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 15,
                        ),
                        child: Container(
                          width: 1.5,
                          height: 450,
                          color: Colors.black.withOpacity(0.2),
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
                                padding: const EdgeInsets.only(
                                    left: 10, bottom: 10, top: 10),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Địa chỉ:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                    const Spacer(),
                                    Flexible(
                                      child: Text(
                                        formModel.propertyWard != null
                                            ? '${formModel.propertyStreet}, ${formModel.propertyWard}, ${formModel.propertyDistrict}, ${formModel.propertyCity}'
                                            : '',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.visible,
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
                                      '${formatCurrency(formModel.propertyRevervePrice.toString())} VNĐ',
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
                                      'Loại tài sản:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      formModel.propertyType?.name ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        128, 146, 142, 142),
                                  ),
                                  color:
                                      const Color.fromARGB(253, 255, 255, 255),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                ),
                                child: SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (formModel
                                            .propertyImages!.first.isEmpty)
                                        ? 1
                                        : formModel.propertyImages!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            print(listImage.length);
                                            selectedImage = listImage[index];
                                            print(selectedImage);
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            listImage[index],
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.4),
                          width: 2,
                        ),
                        color: const Color.fromARGB(253, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Tiêu đề:   ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    formModel.title ?? "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Nội dung:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.visible,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    formModel.content ?? "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 100, top: 50, bottom: 20),
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
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      _bloc.add(DeclinedForm(
                                          id: formModel.id!,
                                          reason: 'Đơn không hợp lệ'));
                                    },
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
                                            fontSize: 15,
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

  String formatCurrency(String input) {
    final formatter = NumberFormat("#,###");
    final number = int.parse(input);
    return formatter.format(number);
  }
}
