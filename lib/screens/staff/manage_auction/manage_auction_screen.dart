import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swp_project_web/models/response/auction_model.dart';
import 'package:swp_project_web/screens/customer/create_form/create_form.dart';
import 'package:swp_project_web/screens/staff/manage_auction/bloc/auction_bloc.dart';
import 'package:swp_project_web/screens/staff/manage_auction/bloc/auction_event.dart';
import 'package:swp_project_web/screens/staff/manage_auction/bloc/auction_state.dart';
import 'package:swp_project_web/screens/staff/manage_auction/create_auction.dart';
import 'package:swp_project_web/theme/pallete.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class ManagePostScreen extends StatefulWidget {
  const ManagePostScreen({Key? key}) : super(key: key);

  @override
  State<ManagePostScreen> createState() => _ManagePostScreenState();
}

class _ManagePostScreenState extends State<ManagePostScreen> {
  List<AuctionModel> listAuction = [];
  final _bloc = AuctionBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllListAuction());
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> _columns = [
      DataColumn(
        label: const Text('ID'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listAuction.sort((a, b) => a.id!.compareTo(b.id as num));
            if (!ascending) {
              listAuction = listAuction.reversed.toList();
            }
          });
        },
      ),
      const DataColumn(
        label: Text('Ảnh bìa'),
      ),
      DataColumn(
        label: const Text('Tên'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listAuction.sort((a, b) => a.name!.compareTo(b.name as String));
            if (!ascending) {
              listAuction = listAuction.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: const Text('Thời gian bắt đầu'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listAuction.sort((a, b) =>
                a.biddingStartTime!.compareTo(b.biddingStartTime as String));
            if (!ascending) {
              listAuction = listAuction.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: const Text('Giá khởi điểm'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listAuction.sort(
                (a, b) => a.revervePrice!.compareTo(b.revervePrice as num));
            if (!ascending) {
              listAuction = listAuction.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: const Text('Trạng thái'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listAuction.sort(
                (a, b) => a.auctionStatus!.compareTo(b.auctionStatus as num));
            if (!ascending) {
              listAuction = listAuction.reversed.toList();
            }
          });
        },
      ),
      const DataColumn(
        label: Text('Xem chi tiết'),
      ),
    ];
    return BlocConsumer<AuctionBloc, AuctionState>(
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
            alignment: Alignment.topRight,
          );
        }
      },
      builder: (context, state) {
        //show popup tạo auction
        void showDetailDialog(BuildContext context) {
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Pallete.sideBarColor,
                titlePadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        'Tạo đấu giá',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
                contentPadding: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 20, top: 8),
                content: Container(
                  constraints: BoxConstraints(
                    minHeight: screenHeight * 0.7,
                    minWidth: screenWidth * 0.8,
                  ),
                  child: const CreateAuction(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(width: 1, color: Colors.grey),
                ),
              );
            },
          );
        }

        return Padding(
          padding: const EdgeInsets.all(15),
          //------------------------LIST-------------------------------
          child: PaginatedDataTable(
            horizontalMargin: 100,
            header: Row(
              children: [
                const Text('Danh sách cuộc đấu giá',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15),
                  child: TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Pallete.sideBarColor)),
                      onPressed: () {
                        showDetailDialog(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Tạo đấu giá',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      )),
                ),
              ],
            ),
            columns: _columns,
            // ignore: deprecated_member_use
            dataRowHeight: 120,
            source: _DataSource(listAuction),
            rowsPerPage: 4,
            availableRowsPerPage: const [4, 8],
          ),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final List<AuctionModel> listAuction;

  _DataSource(this.listAuction);

  @override
  DataRow getRow(int index) {
    final auction = listAuction[index];
    return DataRow(cells: [
      DataCell(Text(auction.id.toString())),
      DataCell(
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(253, 255, 255, 255),
            ),
            color: const Color.fromARGB(253, 255, 255, 255),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: (auction.auctionImages!.isEmpty)
                  ? const AssetImage("assets/images/error_load_image.jpg")
                  : Image.network(auction.auctionImages!.first).image,
            ),
          ),
        ),
      ),
      DataCell(Text(auction.name.toString())),
      DataCell(Text(DateFormat("dd-MM-yyyy hh:mm:ss")
          .format(DateTime.parse(auction.biddingStartTime.toString())))),
      DataCell(Text('${formatCurrency(auction.revervePrice.toString())} VNĐ')),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: displayColor(auction.auctionStatus),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          convertStatus(auction.auctionStatus),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      )),
      DataCell(IconButton(
        onPressed: () {},
        icon: const Icon(Icons.remove_red_eye_outlined),
        iconSize: 20,
        color: Colors.black.withOpacity(0.5),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listAuction.length;

  @override
  int get selectedRowCount => 0;

  String convertStatus(int? postStatus) {
    switch (postStatus) {
      case 0:
        return 'Sắp diễn ra';
      case 1:
        return 'Đang diễn ra';
      case 2:
        return 'Đã kết thúc';
      case 3:
        return 'Thành công';
      case 4:
        return 'Thất bại';
      default:
        return '';
    }
  }

  Color displayColor(int? postStatus) {
    switch (postStatus) {
      case 0:
        return const Color.fromARGB(255, 233, 155, 53);
      case 1:
        return const Color.fromARGB(255, 53, 110, 233);
      case 2:
        return const Color.fromARGB(255, 118, 128, 133);
      case 3:
        return const Color.fromARGB(255, 72, 176, 76);
      case 4:
        return const Color.fromARGB(255, 169, 54, 54);
      default:
        return Colors.white;
    }
  }

  String formatCurrency(String input) {
    final formatter = NumberFormat("#,###");
    final number = int.parse(input);
    return formatter.format(number);
  }
}
