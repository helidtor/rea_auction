// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/provider/api_provider.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_bloc.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_event.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_state.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/field_profile.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class DetailAuction extends StatefulWidget {
  final AuctionModel auctionModel;
  const DetailAuction({
    Key? key,
    required this.auctionModel,
  }) : super(key: key);

  @override
  State<DetailAuction> createState() => _DetailAuctionState();
}

class _DetailAuctionState extends State<DetailAuction> {
  String bidAmount = "";
  final _bloc = AuctionPostBloc();
  late AuctionModel auctionModel;
  List<String> listImage = [];
  String selectedImage = "";
  int isJoinAuction = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auctionModel = widget.auctionModel;
    if (auctionModel.auctionImages!.isNotEmpty) {
      selectedImage = auctionModel.auctionImages!.first;
      listImage = auctionModel.auctionImages!;
      bidAmount = auctionModel.finalPrice.toString();
      _bloc.add(CheckIsJoin(
          idAuction: auctionModel.id!,
          statusAuction: auctionModel.auctionStatus!));
    }
    print('Đây là status của auction ${auctionModel.auctionStatus}');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Pallete.pinkBold,
          shadowColor: Pallete.gradient3,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                icon: const Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                },
              ),
            ),
          ],
        ),
        body: BlocConsumer<AuctionPostBloc, AuctionState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is AuctionLoading) {
              onLoading(context);
              return;
            } else if (state is AuctionJoinedState) {
              Navigator.pop(context);
              isJoinAuction = state.joined;
            } else if (state is JoinAuctionSuccessState) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
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
                    contentText: 'Đăng ký thành công',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            } else if (state is BidAuctionSuccessState) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
              setState(() {
                auctionModel.finalPrice = state.currentPrice;
              });

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
                    contentText: 'Đấu giá thành công',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            } else if (state is BidAuctionFailureState) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
              toastification.show(
                  pauseOnHover: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.blue,
                  ),
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.info,
                  style: ToastificationStyle.minimal,
                  title: const TextContent(
                    contentText: 'Đấu giá thất bại',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 2000),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            } else if (state is AuctionClosed) {
              Navigator.pop(context);
              isJoinAuction = state.joined;
              print('isJoinAuction: ${isJoinAuction}');
              toastification.show(
                  pauseOnHover: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.orange,
                  ),
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.orange,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.warning,
                  style: ToastificationStyle.minimal,
                  title: TextContent(
                    contentText: state.noti,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 61, 42, 42),
                  ),
                  autoCloseDuration: const Duration(milliseconds: 2500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            } else if (state is JoinAuctionErrorState) {
              Navigator.pop(context);
              toastification.show(
                  pauseOnHover: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.red,
                  ),
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.red,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.minimal,
                  title: const TextContent(
                    contentText: 'Đăng ký thất bại',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            }
          },
          builder: (context, state) {
            Widget buildJoinButton() {
              if (isJoinAuction == 1) {
                //chưa diễn ra, đã đăng ký
                return const Text('Đã đăng ký');
              } else if (isJoinAuction == 2) {
                //chưa diễn ra, chưa  đăng ký
                return GradientButton(
                  s: 'Đăng ký',
                  widthButton: 0.3,
                  onPressed: () {
                    _bloc.add(JoinAuction(
                      idAuction: auctionModel.id!,
                    ));
                  },
                );
              } else if (isJoinAuction == 3) {
                //đã kết thúc
                return const Text('Đã kết thúc');
              } else if (isJoinAuction == 4) {
                // return const Text('Đang diễn ra, đã join');
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                    border: Border.all(
                        color: const Color.fromARGB(42, 166, 164, 164)),
                    color: const Color.fromARGB(253, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                      minWidth: screenWidth * 0.3, minHeight: 300),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Giá hiện tại: ${formatCurrency(auctionModel.finalPrice.toString())} VNĐ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      FieldProfile(
                        widthInput: 0.2,
                        readOnly: false,
                        content: '',
                        onChangeText: (value) {
                          setState(() {
                            bidAmount = value;
                          });
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            _bloc.add(BidAuction(
                                idAuction: auctionModel.id!,
                                bidAmount: double.parse(bidAmount)));
                          },
                          child: Container(
                            width: screenWidth * 0.2,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green),
                            child: const Center(
                              child: Text(
                                'Đấu giá',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                );
              } else if (isJoinAuction == 5) {
                return const Text('Đang diễn ra, chưa đăng ký');
              }
              return const SizedBox();
            }

            Widget isOverTime() {
              DateTime dateNow = DateTime.now();
              DateTime startTime =
                  DateTime.parse(auctionModel.biddingStartTime!);
              DateTime endTime = DateTime.parse(auctionModel.biddingEndTime!);
              if (startTime.compareTo(dateNow) > 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thời gian đếm ngược mở đấu giá:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(140, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                        border: Border.all(
                            color: const Color.fromARGB(60, 166, 164, 164)),
                        color: const Color.fromARGB(253, 255, 255, 255),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: screenWidth * 0.3,
                      height: 70,
                      child: TimerCountdown(
                          spacerWidth: 30,
                          descriptionTextStyle: const TextStyle(fontSize: 10),
                          timeTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          daysDescription: 'NGÀY',
                          hoursDescription: 'GIỜ',
                          minutesDescription: 'PHÚT',
                          secondsDescription: 'GIÂY',
                          endTime:
                              DateTime.parse(auctionModel.biddingStartTime!)),
                    ),
                  ],
                );
              } else if (endTime.compareTo(dateNow) > 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thời gian đếm ngược kết thúc đấu giá:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(140, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                        border: Border.all(
                            color: const Color.fromARGB(60, 166, 164, 164)),
                        color: const Color.fromARGB(253, 255, 255, 255),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: screenWidth * 0.3,
                      height: 70,
                      child: TimerCountdown(
                          spacerWidth: 30,
                          descriptionTextStyle: const TextStyle(fontSize: 10),
                          timeTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          daysDescription: 'NGÀY',
                          hoursDescription: 'GIỜ',
                          minutesDescription: 'PHÚT',
                          secondsDescription: 'GIÂY',
                          endTime:
                              DateTime.parse(auctionModel.biddingEndTime!)),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Đã kết thúc:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(140, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                        border: Border.all(
                            color: const Color.fromARGB(60, 166, 164, 164)),
                        color: const Color.fromARGB(253, 255, 255, 255),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      width: screenWidth * 0.3,
                      height: 70,
                      child: TimerCountdown(
                          spacerWidth: 30,
                          descriptionTextStyle: const TextStyle(fontSize: 10),
                          timeTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          daysDescription: 'NGÀY',
                          hoursDescription: 'GIỜ',
                          minutesDescription: 'PHÚT',
                          secondsDescription: 'GIÂY',
                          endTime:
                              DateTime.parse(auctionModel.biddingEndTime!)),
                    ),
                  ],
                );
              }
            }

            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
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
                child: SizedBox(
                  width: screenWidth * 0.77,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          textAlign: TextAlign.left,
                          auctionModel.property?.post?.title ??
                              "Số nhà 22, ngõ 861 đường Quang Trung, phường Phú La, quận Hà Đông, thành phố Hà Nội, theo Giấy chứng nhận Quyền sử dụng đất số AM 27156",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: null,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: screenWidth * 0.4,
                                height: 450,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        253, 255, 255, 255),
                                  ),
                                  color:
                                      const Color.fromARGB(253, 255, 255, 255),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: (selectedImage == "")
                                        ? const AssetImage(
                                            "assets/images/error_load_image.jpg")
                                        : Image.network(selectedImage).image,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: screenWidth * 0.4,
                                child: SizedBox(
                                  height: 100,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (auctionModel
                                            .auctionImages!.isEmpty)
                                        ? 0
                                        : auctionModel.auctionImages!.length,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isOverTime(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            42, 166, 164, 164)),
                                    color: const Color.fromARGB(
                                        253, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: screenWidth * 0.3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Thời gian bắt đầu:',
                                                style: GoogleFonts.notoSans(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                (auctionModel
                                                            .biddingStartTime !=
                                                        null)
                                                    ? DateFormat(
                                                            "dd/MM/yyyy hh:mm:ss")
                                                        .format(DateTime.parse(
                                                            auctionModel
                                                                .biddingStartTime!))
                                                    : "",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Color.fromARGB(
                                                      255, 180, 23, 26),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Thời gian kết thúc:',
                                                style: GoogleFonts.notoSans(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                (auctionModel.biddingEndTime !=
                                                        null)
                                                    ? DateFormat(
                                                            "dd/MM/yyyy hh:mm:ss")
                                                        .format(DateTime.parse(
                                                            auctionModel
                                                                .biddingEndTime!))
                                                    : "",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Color.fromARGB(
                                                      255, 180, 23, 26),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Giá khởi điểm:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "${formatCurrency(auctionModel.revervePrice.toString())}VNĐ",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 180, 23, 26),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Bước giá:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "1% (so với giá khởi điểm)",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Color.fromARGB(
                                                      255, 180, 23, 26),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Bước giá tối đa/lần trả:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "10 bước giá",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Color.fromARGB(
                                                      255, 180, 23, 26),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Diện tích:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                auctionModel.property?.area !=
                                                        null
                                                    ? '${auctionModel.property?.area}m\u00b2'
                                                    : '0m\u00b2',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 180, 23, 26),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Địa chỉ:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                ),
                                                overflow: TextOverflow.visible,
                                              ),
                                              const Spacer(),
                                              Flexible(
                                                child: Text(
                                                  textAlign: TextAlign.end,
                                                  auctionModel.property?.ward !=
                                                          null
                                                      ? '${auctionModel.property!.street}, ${auctionModel.property!.ward}, ${auctionModel.property!.district}, ${auctionModel.property!.city}'
                                                      : 'Chưa xác định',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 180, 23, 26),
                                                    fontSize: 13,
                                                  ),
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                buildJoinButton(),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //     top: 30,
                          //     left: 15,
                          //   ),
                          //   child: Container(
                          //     width: 1.5,
                          //     height: 450,
                          //     color: Colors.black.withOpacity(0.2),
                          //   ),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: 200, maxWidth: screenWidth * 0.75),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              )
                            ],
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.4),
                              width: 0.5,
                            ),
                            color: const Color.fromARGB(253, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tên tài sản:   ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        auctionModel.name ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 20, right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nội dung:',
                                      style: GoogleFonts.notoSans(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Flexible(
                                      child: Text(
                                        auctionModel.content ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  String formatCurrency(String input) {
    final formatter = NumberFormat("#,###");
    final number = int.parse(input);
    return formatter.format(number);
  }
}
