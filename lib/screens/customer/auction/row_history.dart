// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:swp_project_web/format/format_provider.dart';

import 'package:swp_project_web/models/response/auction_history.dart';
import 'package:swp_project_web/theme/pallete.dart';

class RowHistory extends StatefulWidget {
  AuctionHistory auctionHistory;
  RowHistory({
    Key? key,
    required this.auctionHistory,
  }) : super(key: key);

  @override
  State<RowHistory> createState() => _RowHistoryState();
}

class _RowHistoryState extends State<RowHistory> {
  AuctionHistory? auctionHistory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auctionHistory = widget.auctionHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 30, bottom: 10),
      child: Row(
        children: [
          Container(
            // ảnh ava
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.3),
              ),
              color: const Color.fromARGB(253, 255, 255, 255),
              borderRadius: BorderRadius.circular(500),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: (auctionHistory?.user?.avatarUrl != null)
                    ? Image.network(auctionHistory!.user!.avatarUrl!).image
                    : const AssetImage("assets/images/ava_default.png"),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          (auctionHistory != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${auctionHistory?.user!.firstName} ${auctionHistory?.user!.lastName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Pallete.gradient3,
                          fontSize: 16),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${FormatProvider().formatCurrency(auctionHistory!.biddingAmount!.toString())} VNĐ',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      DateFormat("dd/MM  hh:mm:ss")
                          .format(DateTime.parse(auctionHistory!.createdAt!)),
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black.withOpacity(0.6),
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
