import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/models/response/form_auction.dart';
import 'package:swp_project_web/models/response/property_model.dart';
import 'package:swp_project_web/screens/manage/manage_auction/bloc/auction_bloc.dart';
import 'package:swp_project_web/screens/manage/manage_auction/bloc/auction_event.dart';
import 'package:swp_project_web/screens/manage/manage_auction/bloc/auction_state.dart';
import 'package:swp_project_web/widgets/field_profile.dart';
import 'package:swp_project_web/widgets/input/input_have_label.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/notification/toast.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class CreateAuction extends StatefulWidget {
  const CreateAuction({super.key});

  @override
  State<CreateAuction> createState() => _CreateAuctionState();
}

class _CreateAuctionState extends State<CreateAuction> {
  String formattedDateTimeStart = getCurrentDateTimeFormatted();
  String formattedDateTimeEnd = getCurrentDateTimeFormatted();
  final _bloc = AuctionBloc();
  late List<PropertyModel>? listProperty;
  List<String> listNameProperty = [];
  List<String> noList = ["Không có tài sản"];
  int? idProperty;
  PropertyModel propertyModel = PropertyModel();
  FormAuction inforAuction = FormAuction();
  bool isShow = false;
  List<String> listImage = [];
  String selectedImage = "";

  //ràng buộc thêm field khác để hết lỗi trùng/////////////////////////////////////////////////////////
  int? idPropertyChosen(String value) {
    for (int i = 0; i < listProperty!.length; i++) {
      if (listProperty![i].post!.title == value) {
        return listProperty![i].id;
      }
    }
  }

  @override
  void initState() {
    _bloc.add(GetListProperty());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuctionBloc, AuctionState>(
        bloc: _bloc,
        listener: (context, state) async {
          if (state is AuctionLoading) {
            onLoading(context);
            return;
          } else if (state is CreateAuctionSuccess) {
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
                  contentText: "Tạo đấu giá thành công",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                autoCloseDuration: const Duration(milliseconds: 1500),
                animationDuration: const Duration(milliseconds: 500),
                alignment: Alignment.topRight);
          } else if (state is AuctionSuccess) {
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state is SuccessGetListProperty) {
            Navigator.pop(context);
            listProperty = state.list;
            listNameProperty = state.listName;
          } else if (state is PropertySuccess) {
            Navigator.pop(context);
            propertyModel = state.propertyModel;
            if (propertyModel.images!.isNotEmpty) {
              listImage = propertyModel.images!;
              selectedImage = listImage.first;
              inforAuction.auctionImages = propertyModel.images!;
              inforAuction.propertyId = propertyModel.id;
              inforAuction.name = propertyModel.name;
              inforAuction.revervePrice = propertyModel.revervePrice;
              inforAuction.content = propertyModel.post!.content;
              inforAuction.title = propertyModel.post!.title;
            }
            isShow = true;
          } else if (state is AuctionError) {
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
          void showFullImage(BuildContext context, String fullImage) {
            double screenWidth = MediaQuery.of(context).size.width;
            double screenHeight = MediaQuery.of(context).size.height;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.black,
                  titlePadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.network(fullImage).image,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 1, color: Colors.grey),
                  ),
                );
              },
            );
          }

          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(253, 255, 255, 255),
                  ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 30, top: 20, bottom: 10),
                        width: 400,
                        height: 48,
                        child: CustomDropdown<String>.search(
                          decoration: CustomDropdownDecoration(
                            closedBorder:
                                Border.all(color: Colors.grey, width: 1),
                            closedSuffixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                          ),
                          searchHintText: "Tìm kiếm",
                          hintText: "Chọn tài sản để tạo đấu giá",
                          noResultFoundText: "Tài sản không tồn tại",
                          items: (listNameProperty.isNotEmpty
                              ? listNameProperty
                              : noList),
                          onChanged: (value) {
                            setState(() {
                              idProperty = idPropertyChosen(value);
                              print('Id nhập: $idProperty');
                              _bloc.add(GetPropertyById(id: idProperty!));
                              isShow = false;
                            });
                          },
                        ),
                      ),
                      const Spacer(),
                      isShow
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 25, top: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        print(
                                            "Thông tin tạo auction lúc nhập: $inforAuction");
                                        _bloc.add(CreateAuctionPost(
                                            formAuction: inforAuction));
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.green),
                                        child: const Center(
                                          child: Text(
                                            'Tạo',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red),
                                        child: const Center(
                                          child: Text(
                                            'Hủy',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  listImage.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 20),
                              child: Text(
                                'Hình ảnh',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              // width: 900,
                              margin: const EdgeInsets.only(
                                  left: 15, top: 5, right: 15, bottom: 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(128, 146, 142, 142),
                                ),
                                color: const Color.fromARGB(253, 255, 255, 255),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      (propertyModel.images!.first.isEmpty)
                                          ? 1
                                          : propertyModel.images!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedImage = listImage[index];
                                          showFullImage(context, selectedImage);
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
                        )
                      : const SizedBox(),
                  isShow
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      'Thông tin chung',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15, top: 5, bottom: 15),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(174, 239, 237, 237),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          InputHaveLabel(
                                            labelText: 'Tên tài sản',
                                            initialText: propertyModel.name ??
                                                'Tên tài sản trống',
                                            onChangeText: (value) {
                                              setState(() {
                                                inforAuction.name = value;
                                              });
                                            },
                                          ),
                                          InputHaveLabel(
                                            labelText: 'Tiêu đề',
                                            initialText:
                                                propertyModel.post?.title ??
                                                    'Tiêu đề trống',
                                          ),
                                          InputHaveLabel(
                                            labelText: 'Địa chỉ',
                                            initialText:
                                                '${propertyModel.ward}, ${propertyModel.district}, ${propertyModel.city}',
                                          ),
                                          InputHaveLabel(
                                            labelText: 'Diện tích',
                                            initialText:
                                                propertyModel.area.toString(),
                                          ),
                                          InputHaveLabel(
                                            labelText: 'Giá khởi điểm',
                                            initialText: propertyModel
                                                .revervePrice
                                                .toString(),
                                            onChangeText: (value) {
                                              setState(() {
                                                inforAuction.revervePrice =
                                                    double.parse(value);
                                              });
                                            },
                                          ),
                                          InputHaveLabel(
                                            labelText: 'Nội dung',
                                            initialText:
                                                propertyModel.post!.content,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 15, right: 20, top: 5, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                        128, 157, 153, 153),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      //Thời gian mở
                                      Text(
                                        'Thời gian bắt đầu',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              174, 239, 237, 237),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            final DateTime? selectedDateTime =
                                                await showDateTimePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );

                                            if (selectedDateTime != null) {
                                              setState(() {
                                                formattedDateTimeStart =
                                                    convertDateTimeFormat(
                                                        selectedDateTime
                                                            .toString());
                                                inforAuction.biddingStartTime =
                                                    formattedDateTimeStart;
                                              });
                                            }
                                          },
                                          child: Text(
                                            convertDateTimeDisplay(
                                                formattedDateTimeStart), // Hiển thị dữ liệu
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      //Thời gian kết thúc
                                      Text(
                                        'Thời gian kết thúc',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              174, 239, 237, 237),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            final DateTime? selectedDateTime =
                                                await showDateTimePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );

                                            if (selectedDateTime != null) {
                                              setState(() {
                                                formattedDateTimeEnd =
                                                    convertDateTimeFormat(
                                                        selectedDateTime
                                                            .toString());
                                                inforAuction.biddingEndTime =
                                                    formattedDateTimeEnd;
                                              });
                                            }
                                          },
                                          child: Text(
                                            convertDateTimeDisplay(
                                                formattedDateTimeEnd), // Hiển thị dữ liệu
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      const InputHaveLabel(
                                        readOnly: true,
                                        labelText: 'Bước giá',
                                        initialText: '1% (theo giá khởi điểm)',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String convertDateTimeFormat(String inputDateTime) {
    final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    final outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    final dateTime = inputFormat.parse(inputDateTime);
    final formattedDateTime = outputFormat.format(dateTime);
    return formattedDateTime;
  }

  String convertDateTimeDisplay(String inputDateTime) {
    final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    final outputFormat = DateFormat("dd/MM/yyyy - HH:mm");
    final dateTime = inputFormat.parse(inputDateTime);
    final formattedDateTime = outputFormat.format(dateTime);
    return formattedDateTime;
  }
}

String getCurrentDateTimeFormatted() {
  final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
  final String formattedDateTime = formatter.format(DateTime.now());
  return formattedDateTime;
}

Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= initialDate.subtract(const Duration(days: 365));
  lastDate ??= firstDate.add(const Duration(days: 365 * 2));

  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (selectedDate == null) return null;

  if (!context.mounted) return selectedDate;

  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedDate),
  );

  return selectedTime == null
      ? selectedDate
      : DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
}
