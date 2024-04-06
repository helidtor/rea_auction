import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:swp_project_web/format/format_provider.dart';
import 'package:swp_project_web/models/response/form_model.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/router/router.dart';
import 'package:swp_project_web/screens/customer/create_form/bloc/form_bloc.dart';
import 'package:swp_project_web/screens/customer/create_form/bloc/form_event.dart';
import 'package:swp_project_web/screens/customer/create_form/bloc/form_state.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/bar/footer_web.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/input_field.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';
import 'package:swp_project_web/widgets/input/input_price.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/notification/toast.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';
import 'dart:typed_data';

class CreateForm extends StatefulWidget {
  const CreateForm({Key? key}) : super(key: key);

  @override
  State<CreateForm> createState() => _CreateFormStates();
}

class _CreateFormStates extends State<CreateForm> {
  String? dropdownValue;
  bool imageAvailable = false;
  late String imageName;
  late Uint8List imageFile;
  List<Uint8List> listImageFile = [];
  List<String> ListImageName = [];
  final _bloc = FormBloc();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _namePropertyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _typePropertyController = TextEditingController();
  FormsModel formCreate = FormsModel();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: TopBar(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
      ),
      body: BlocConsumer<FormBloc, FormStatess>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is FormStatesLoading) {
            onLoading(context);
            return;
          } else if (state is FormStatesSuccess) {
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
          } else if (state is FormStatesFailure) {
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
                                  formCreate.title = value;
                                });
                              },
                              content: 'Tiêu đề',
                              controller: _titleController,
                              widthInput: 0.3,
                            ),
                            const SizedBox(width: 20),
                            InputField(
                                onChangeText: (value) {
                                  setState(() {
                                    formCreate.propertyName = value;
                                  });
                                },
                                content: 'Tên tài sản',
                                controller: _namePropertyController,
                                widthInput: 0.3),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InputField(
                          onChangeText: (value) {
                            setState(() {
                              formCreate.content = value;
                            });
                          },
                          content: 'Nội dung',
                          controller: _contentController,
                          widthInput: 0.61,
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: screenWidth * 0.61,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Pallete.gradient3,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 168, 167, 167),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            hint: const Text('Loại tài sản'),
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                if (dropdownValue == 'Nhà') {
                                  formCreate.propertyTypeId = 1;
                                } else if (dropdownValue == 'Đất') {
                                  formCreate.propertyTypeId = 2;
                                }
                              });
                            },
                            items: <String>['Nhà', 'Đất']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
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
                        const SizedBox(height: 25),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              'Địa chỉ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputField(
                              onChangeText: (value) {
                                setState(() {
                                  formCreate.propertyStreet = value;
                                });
                              },
                              content: "Đường",
                              controller: _streetController,
                              widthInput: 0.3,
                            ),
                            const SizedBox(width: 20),
                            InputField(
                                onChangeText: (value) {
                                  setState(() {
                                    formCreate.propertyWard = value;
                                  });
                                },
                                content: "Phường/Xã",
                                controller: _wardController,
                                widthInput: 0.3),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputField(
                              onChangeText: (value) {
                                setState(() {
                                  formCreate.propertyDistrict = value;
                                });
                              },
                              content: "Quận/Huyện",
                              controller: _districtController,
                              widthInput: 0.3,
                            ),
                            const SizedBox(width: 20),
                            InputField(
                                onChangeText: (value) {
                                  setState(() {
                                    formCreate.propertyCity = value;
                                  });
                                },
                                content: "Tỉnh/Thành",
                                controller: _cityController,
                                widthInput: 0.3),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputField(
                              onChangeText: (value) {
                                setState(() {
                                  formCreate.propertyArea = double.parse(value);
                                });
                              },
                              content: "Diện tích(m\u00b2)",
                              controller: _areaController,
                              widthInput: 0.3,
                            ),
                            const SizedBox(width: 20),
                            InputPrice(
                                onChangeText: (value) {
                                  setState(() {
                                    formCreate.propertyRevervePrice =
                                        double.parse(FormatProvider()
                                            .formatString(value));
                                  });
                                },
                                content: "Giá khởi điểm",
                                controller: _priceController,
                                widthInput: 0.3),
                          ],
                        ),
                        const SizedBox(height: 50),
                        GradientButton(
                          s: 'Gửi đơn',
                          widthButton: 0.611,
                          onPressed: () async {
                            var linkUrl = await ApiProvider.uploadMultiImage(
                                listImageFile, ListImageName);
                            if (linkUrl!.isNotEmpty) {
                              if (formCreate.propertyImages == null) {
                                formCreate.propertyImages = [];
                                formCreate.propertyImages = linkUrl;
                              }
                            }
                            print("Thông tin điền vào form: $formCreate");
                            _bloc.add(CreateFormEvent(formModel: formCreate));
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
