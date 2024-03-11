// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:swp_project_web/firebase/auth.dart';
import 'package:swp_project_web/models/response/auction_model.dart';

import 'package:swp_project_web/models/response/form_model.dart';
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
      height: screenHeight * 0.75,
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
                      ? DateFormat("dd-MM-yyyy hh:mm:ss")
                          .format(DateTime.parse(auctionModel.biddingStartTime!))
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
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: 'Khởi điểm: ',
                      style: TextStyle(fontSize: 15, color: Pallete.hintColor)),
                  TextSpan(
                    text: '${auctionModel.revervePrice} triệu',
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
                  onPressed: () {},
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
}
