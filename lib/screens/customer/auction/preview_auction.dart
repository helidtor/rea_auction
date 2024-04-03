// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swp_project_web/models/response/auction_model.dart';

import 'package:swp_project_web/screens/customer/auction/detail_auction.dart';
import 'package:swp_project_web/theme/pallete.dart';

class PreviewAuction extends StatefulWidget {
  AuctionModel auctionModel;
  PreviewAuction({
    Key? key,
    required this.auctionModel,
  }) : super(key: key);

  @override
  State<PreviewAuction> createState() => _PreviewAuction();
}

class _PreviewAuction extends State<PreviewAuction> {
  late AuctionModel auctionModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auctionModel = widget.auctionModel;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 570,
      width: screenWidth * 0.2,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(253, 255, 255, 255),
          ),
          color: const Color.fromARGB(253, 255, 255, 255),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Thời gian đấu giá',
                style: TextStyle(
                    fontSize: 18,
                    color: Pallete.gradient3,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (auctionModel.biddingStartTime != null)
                      ? DateFormat("dd-MM-yyyy hh:mm:ss").format(
                          DateTime.parse(auctionModel.biddingStartTime!))
                      : "",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Text(""),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: screenWidth * 0.18,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(253, 255, 255, 255),
                ),
                color: const Color.fromARGB(253, 255, 255, 255),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: (auctionModel.auctionImages!.isEmpty)
                      ? const AssetImage("assets/images/error_load_image.jpg")
                      : Image.network(auctionModel.auctionImages!.first).image,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              auctionModel.name!,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              auctionModel.content ?? "",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: 'Khởi điểm: ',
                      style: TextStyle(fontSize: 15, color: Pallete.hintColor)),
                  TextSpan(
                    text:
                        "${formatCurrency(auctionModel.revervePrice.toString())}VNĐ",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setInt("idAuction", auctionModel.id!);
                    // print('Chi tiết đấu giá: ${auctionModel}');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailAuction()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.pinkBold,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Chi tiết',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.share,
                    color: Pallete.pinkBold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  String formatCurrency(String input) {
    // Định dạng số tiền có dấu phẩy ngăn cách hàng nghìn và dấu chấm phẩy phân cách phần thập phân
    final formatter = NumberFormat("#,###");
    // Chuyển đổi chuỗi thành số nguyên
    final number = int.parse(input);
    // Áp dụng định dạng tiền tệ và trả về chuỗi đã được định dạng
    return formatter.format(number);
  }
}