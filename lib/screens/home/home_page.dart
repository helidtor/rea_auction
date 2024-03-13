import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_bloc.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_event.dart';
import 'package:swp_project_web/screens/auction/bloc/auction_state.dart';
import 'package:swp_project_web/screens/auction/preview_auction.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/bar/footer_web.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';
import 'package:swp_project_web/widgets/button/gradient_button.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:swp_project_web/widgets/review_post.dart';
import 'package:toastification/toastification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  List<AuctionModel> listAuction = [];
  ScrollController scrollController = ScrollController();
  final _bloc = AuctionPostBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllListAuction());
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
      body: BlocConsumer<AuctionPostBloc, AuctionState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is AuctionLoading) {
              onLoading(context);
              return;
            } else if (state is AuctionSuccess) {
              Navigator.pop(context);
              listAuction = state.list;
            } else if (state is AuctionError) {
              toastification.show(
                  pauseOnHover: false,
                  progressBarTheme: const ProgressIndicatorThemeData(
                    color: Colors.red,
                  ),
                  icon: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
                  foregroundColor: Colors.black,
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.minimal,
                  title: TextContent(
                    contentText: state.error,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  autoCloseDuration: const Duration(milliseconds: 1500),
                  animationDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.topRight);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/background_1.jpg"),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Stack(children: [
                    Positioned(
                      right: 0,
                      top: screenHeight * 0.10,
                      child: Container(
                          height: screenHeight * 0.7,
                          width: screenWidth * 0.35,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 196, 49, 71),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(250),
                                topLeft: Radius.circular(250),
                              ))),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth * 0.1,
                              screenHeight * 0.2,
                              screenWidth * 0.1,
                              screenHeight * 0.2),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Chào mừng bạn đến với REA',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Pallete.gradient3,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  const Text(
                                    'Nền tảng đấu giá trực tuyến',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  const Text(
                                    'Tự hào là một trong những nhà đấu giá lớn nhất tại Việt Nam, \nREA luôn là đơn vị tiên phong ứng dụng công nghệ thông tin \nvào hoạt động đấu giá. REA vinh dự tổ chức thành công \ncuộc đấu giá trực tuyến chính thống đầu tiên tại Việt Nam, \nmở ra 1 chương mới cho hoạt động đấu giá nước nhà.',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  GradientButton(
                                    onPressed: () {
                                      print(
                                          "image post 2: ${listAuction.first.auctionImages}");
                                    },
                                    s: 'Khám phá',
                                    widthButton: 0.2,
                                  )
                                ],
                              ),
                              const Spacer(),
                              Container(
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.5,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/image_template.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Column(
                              children: [
                                const Text(
                                  '- Tài sản sắp mở đấu giá -',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                //------------------------LIST-------------------------------
                                SizedBox(
                                  width: screenWidth * 0.85,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        listAuction.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: PreviewAuction(
                                              auctionModel: listAuction[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: GradientButton(
                                      s: 'Xem tất cả', widthButton: 0.15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Column(children: [
                              const Text(
                                '- Tài sản đang đấu giá -',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              //------------------------LIST-------------------------------
                              Row(children: [
                                const Spacer(),
                                const ReviewPost(),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                const ReviewPost(),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                const ReviewPost(),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                const ReviewPost(),
                                const Spacer(),
                              ]),
                              const SizedBox(
                                height: 50,
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: GradientButton(
                                    s: 'Xem tất cả', widthButton: 0.15),
                              ),
                            ]),
                          ),
                        ),
                        const FooterWeb(),
                      ],
                    ),
                  ]),
                ),
              ],
            );
          }),
    );
  }
}
