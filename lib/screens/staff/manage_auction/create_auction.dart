import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swp_project_web/format/format_provider.dart';
import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/models/response/form_auction.dart';
import 'package:swp_project_web/models/response/property_model.dart';
import 'package:swp_project_web/screens/staff/manage_auction/bloc/auction_bloc.dart';
import 'package:swp_project_web/screens/staff/manage_auction/bloc/auction_event.dart';
import 'package:swp_project_web/screens/staff/manage_auction/bloc/auction_state.dart';
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
  DateTime selectedDateTimeEnd = DateTime.now();
  String formattedDateTimeStart =
      FormatProvider().getCurrentDateTimeFormatted();
  String formattedDateTimeEnd = FormatProvider().getCurrentDateTimeFormatted();
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

  int? idPropertyChosen(String value) {
    for (int i = 0; i < listProperty!.length; i++) {
      if (listProperty![i].post!.title == value &&
          listProperty![i].isAvailable == true) {
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
              inforAuction.stepFee = propertyModel.revervePrice! * 0.1;
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
                                        if (inforAuction.biddingStartTime ==
                                                null ||
                                            inforAuction.biddingEndTime ==
                                                null) {
                                          toastification.show(
                                              pauseOnHover: false,
                                              progressBarTheme:
                                                  const ProgressIndicatorThemeData(
                                                color: Colors.orange,
                                              ),
                                              icon: const Icon(
                                                Icons.check_circle,
                                                color: Colors.orange,
                                              ),
                                              foregroundColor: Colors.black,
                                              context: context,
                                              type: ToastificationType.warning,
                                              style:
                                                  ToastificationStyle.minimal,
                                              title: const TextContent(
                                                contentText:
                                                    'Vui lòng chọn ngày bắt đầu và kết thúc hợp lệ!',
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 61, 42, 42),
                                              ),
                                              autoCloseDuration: const Duration(
                                                  milliseconds: 2500),
                                              animationDuration: const Duration(
                                                  milliseconds: 500),
                                              alignment: Alignment.topRight);
                                        } else {
                                          print(
                                              "Thông tin tạo auction lúc nhập: $inforAuction");
                                          _bloc.add(CreateAuctionPost(
                                              formAuction: inforAuction));
                                        }
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
                                            onChangeText: (value) {
                                              setState(() {
                                                inforAuction.title = value;
                                              });
                                            },
                                          ),
                                          InputHaveLabel(
                                            readOnly: true,
                                            labelText: 'Địa chỉ',
                                            initialText:
                                                '${propertyModel.ward}, ${propertyModel.district}, ${propertyModel.city}',
                                          ),
                                          InputHaveLabel(
                                            readOnly: true,
                                            labelText: 'Diện tích (m\u00b2)',
                                            initialText:
                                                propertyModel.area.toString(),
                                          ),
                                          InputHaveLabel(
                                            labelText: 'Giá khởi điểm (VNĐ)',
                                            initialText: FormatProvider()
                                                .formatCurrency(propertyModel
                                                    .revervePrice
                                                    .toString()),
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
                                            onChangeText: (value) {
                                              setState(() {
                                                inforAuction.content = value;
                                              });
                                            },
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
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(
                                                  const Duration(days: 30)),
                                            );

                                            if (selectedDateTime != null &&
                                                selectedDateTime
                                                    .isAfter(DateTime.now())) {
                                              setState(() {
                                                selectedDateTimeEnd =
                                                    selectedDateTime;
                                                formattedDateTimeStart =
                                                    FormatProvider()
                                                        .convertDateTimeFormat(
                                                            selectedDateTime
                                                                .toString());
                                                inforAuction.biddingStartTime =
                                                    formattedDateTimeStart;
                                              });
                                            } else if (selectedDateTime !=
                                                null) {
                                              toastification.show(
                                                  pauseOnHover: false,
                                                  progressBarTheme:
                                                      const ProgressIndicatorThemeData(
                                                    color: Colors.orange,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.orange,
                                                  ),
                                                  foregroundColor: Colors.black,
                                                  context: context,
                                                  type: ToastificationType
                                                      .warning,
                                                  style: ToastificationStyle
                                                      .minimal,
                                                  title: const TextContent(
                                                    contentText:
                                                        'Vui lòng chọn thời gian bắt đầu trong tương lai!',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 61, 42, 42),
                                                  ),
                                                  autoCloseDuration:
                                                      const Duration(
                                                          milliseconds: 2500),
                                                  animationDuration:
                                                      const Duration(
                                                          milliseconds: 500),
                                                  alignment:
                                                      Alignment.topRight);
                                            }
                                          },
                                          child: Text(
                                            FormatProvider().convertDateTimeDisplay(
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
                                              initialDate: selectedDateTimeEnd!
                                                  .add(const Duration(
                                                      minutes: 30)),
                                              firstDate: selectedDateTimeEnd!
                                                  .add(const Duration(
                                                      minutes: 30)),
                                              lastDate: selectedDateTimeEnd!
                                                  .add(
                                                      const Duration(days: 30)),
                                            );

                                            if (selectedDateTime != null &&
                                                selectedDateTime.isAfter(
                                                    selectedDateTimeEnd!)) {
                                              setState(() {
                                                formattedDateTimeEnd =
                                                    FormatProvider()
                                                        .convertDateTimeFormat(
                                                            selectedDateTime
                                                                .toString());
                                                inforAuction.biddingEndTime =
                                                    formattedDateTimeEnd;
                                              });
                                            } else if (selectedDateTime !=
                                                null) {
                                              toastification.show(
                                                  pauseOnHover: false,
                                                  progressBarTheme:
                                                      const ProgressIndicatorThemeData(
                                                    color: Colors.orange,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.orange,
                                                  ),
                                                  foregroundColor: Colors.black,
                                                  context: context,
                                                  type: ToastificationType
                                                      .warning,
                                                  style: ToastificationStyle
                                                      .minimal,
                                                  title: const TextContent(
                                                    contentText:
                                                        'Vui lòng chọn thời gian kết thúc sau thời gian bắt đầu!',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 61, 42, 42),
                                                  ),
                                                  autoCloseDuration:
                                                      const Duration(
                                                          milliseconds: 2500),
                                                  animationDuration:
                                                      const Duration(
                                                          milliseconds: 500),
                                                  alignment:
                                                      Alignment.topRight);
                                            }
                                          },
                                          child: Text(
                                            FormatProvider().convertDateTimeDisplay(
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

                                      InputHaveLabel(
                                        labelText: 'Số bước giá tối đa',
                                        initialText: '5',
                                        onChangeText: (value) {
                                          setState(() {
                                            inforAuction.maxStepFee =
                                                int.parse(value);
                                          });
                                        },
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
}
