import 'dart:typed_data';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:swp_project_web/models/response/form_done_model.dart';
import 'package:swp_project_web/models/response/property_model.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/screens/customer/create_form_complete/bloc/form_complete_bloc.dart';
import 'package:swp_project_web/screens/customer/create_form_complete/bloc/form_complete_event.dart';
import 'package:swp_project_web/screens/customer/create_form_complete/bloc/form_complete_state.dart';
import 'package:swp_project_web/widgets/bar/footer_web.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/input_field.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/notification/toast.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';
import 'dart:typed_data';

class FormComplete extends StatefulWidget {
  const FormComplete({Key? key}) : super(key: key);

  @override
  State<FormComplete> createState() => _FormCompleteStates();
}

class _FormCompleteStates extends State<FormComplete> {
  List<String> noList = ["Không có tài sản"];
  late List<PropertyModel>? listProperty;
  List<String> listNameProperty = [];
  String? dropdownValue;
  bool imageAvailable = false;
  late String imageName;
  late Uint8List imageFile;
  List<Uint8List> listImageFile = [];
  List<String> ListImageName = [];
  final _bloc = FormCompleteBloc();
  int? idProperty;
  FormDoneModel formDoneModel = FormDoneModel();

  int? idPropertyChosen(String value) {
    for (int i = 0; i < listProperty!.length; i++) {
      if (listProperty![i].post!.title == value &&
          listProperty![i].isAvailable == true) {
        return listProperty![i].id;
      }
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    _bloc.add(GetListPropertyDone());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TopBar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      ),
      body: BlocConsumer<FormCompleteBloc, FormCompleteState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is FormCompleteLoading) {
            onLoading(context);
            return;
          } else if (state is SuccessGetListPropertyDone) {
            Navigator.pop(context);
            listProperty = state.list;
            listNameProperty = state.listName;
          } else if (state is FormCompleteSuccess) {
            router.go(RouteName.home);
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
                title: TextContent(
                  contentText: state.success,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                autoCloseDuration: const Duration(milliseconds: 1500),
                animationDuration: const Duration(milliseconds: 500),
                alignment: Alignment.topRight);
          } else if (state is FormCompleteFailure) {
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: screenWidth * 0.15,
                    right: screenWidth * 0.15,
                    // bottom: screenHeight * 0.05,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(166, 166, 164, 164)),
                      color: const Color.fromARGB(253, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              'Thông tin đơn',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputField(
                              onChangeText: (value) {
                                setState(() {
                                  formDoneModel.title = value;
                                });
                              },
                              content: 'Tiêu đề',
                              controller: _titleController,
                              widthInput: 0.3,
                            ),
                            const SizedBox(width: 20),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 30, top: 20, bottom: 10),
                              width: 400,
                              height: 48,
                              child: CustomDropdown<String>.search(
                                decoration: CustomDropdownDecoration(
                                  closedBorder:
                                      Border.all(color: Colors.grey, width: 1),
                                  closedSuffixIcon: const Icon(Icons.search,
                                      color: Colors.grey),
                                ),
                                searchHintText: "Tìm kiếm",
                                hintText: "Chọn tài sản để tạo đơn",
                                noResultFoundText: "Tài sản không tồn tại",
                                items: (listNameProperty.isNotEmpty
                                    ? listNameProperty
                                    : noList),
                                onChanged: (value) {
                                  setState(() {
                                    formDoneModel.propertyId =
                                        idPropertyChosen(value);
                                    print('Id nhập: $idProperty');
                                    // _bloc.add(GetPropertyById(id: idProperty!));
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        InputField(
                          onChangeText: (value) {
                            setState(() {
                              formDoneModel.content = value;
                            });
                          },
                          content: 'Nội dung',
                          controller: _contentController,
                          widthInput: 0.6,
                        ),
                        const SizedBox(height: 35),
                        //Chọn hình ảnh/////////////////////////////////////////////////////
                        GestureDetector(
                          onTap: () async {
                            final image =
                                await ImagePickerWeb.getImageAsBytes();
                            final fileName = DateTime.now().toString();
                            setState(() {
                              imageFile = image!;
                              listImageFile.add(imageFile);
                              imageAvailable = true;
                              imageName = fileName;
                              ListImageName.add(imageName);
                            });
                          },
                          child: Container(
                            height: 40,
                            width: screenWidth * 0.61,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 168, 167, 167)),
                            ),
                            child: const Icon(
                              Icons.upload,
                              color: Color.fromARGB(255, 168, 167, 167),
                            ),
                          ),
                        ),
                        imageAvailable
                            ? Row(
                                children: [
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              width: 1,
                                              color: const Color.fromARGB(
                                                  255, 168, 167, 167)),
                                        ),
                                        height: 100,
                                        width: 100,
                                        child: imageAvailable
                                            ? Image.memory(
                                                imageFile,
                                              )
                                            : const SizedBox(),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.15,
                    right: screenWidth * 0.15,
                    bottom: screenHeight * 0.05,
                    top: 3,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(166, 166, 164, 164)),
                      color: const Color.fromARGB(253, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        GradientButton(
                          s: 'Gửi đơn',
                          widthButton: 0.8,
                          onPressed: () async {
                            var linkUrl = await ApiProvider.uploadMultiImage(
                                listImageFile, ListImageName);
                            if (linkUrl!.isNotEmpty) {
                              if (formDoneModel.transferImages == null) {
                                formDoneModel.transferImages = [];
                                formDoneModel.transferImages = linkUrl;
                              }
                            }
                            _bloc.add(CreateFormCompleteEvent(
                                formDoneModel: formDoneModel));
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                const FooterWeb(),
              ],
            ),
          );
        },
      ),
    );
  }
}
