// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/widgets/bar/top_bar.dart';

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
  late AuctionModel auctionModel;
  List<String> listImage = [];
  String selectedImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auctionModel = widget.auctionModel;
    if (auctionModel.auctionImages!.isNotEmpty) {
      selectedImage = auctionModel.auctionImages!.first;
      listImage = auctionModel.auctionImages!;
    }
    print('Đây là auction của trang detail ${auctionModel.property}');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: const Color.fromARGB(255, 254, 249, 243),
        shadowColor: const Color.fromARGB(255, 148, 146, 146),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
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
                                  auctionModel.id.toString() ?? "",
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
                                  'Thời gian bắt đầu:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  (auctionModel.biddingStartTime != null)
                                      ? DateFormat("dd-MM-yyyy hh:mm:ss")
                                          .format(DateTime.parse(
                                              auctionModel.biddingStartTime!))
                                      : "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Bước giá:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                Text("1% (so với giá khởi điểm)"),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Bước giá tối đa/lần trả:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                Text("10 bước giá"),
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
                                    auctionModel.property?.ward != null
                                        ? '${auctionModel.property!.street}, ${auctionModel.property!.ward}, ${auctionModel.property!.district}, ${auctionModel.property!.city}'
                                        : 'Chưa xác định',
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
                                  auctionModel.property?.area != null
                                      ? '${auctionModel.property?.area}m\u00b2'
                                      : '0m\u00b2',
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
                                  "${formatCurrency(auctionModel.revervePrice.toString())}VNĐ",
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
                                color: const Color.fromARGB(128, 146, 142, 142),
                              ),
                              color: const Color.fromARGB(253, 255, 255, 255),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (auctionModel.auctionImages!.isEmpty)
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 300),
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
                              'Tên tài sản:   ',
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
                                auctionModel.name ?? "",
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
                                auctionModel.content ?? "",
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatCurrency(String input) {
    final formatter = NumberFormat("#,###");
    final number = int.parse(input);
    return formatter.format(number);
  }
}
