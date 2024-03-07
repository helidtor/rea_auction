import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/models/response/form_model.dart';
import 'package:swp_project_web/screens/manage/manage_form/bloc/form_bloc.dart';
import 'package:swp_project_web/screens/manage/manage_form/bloc/form_event.dart';
import 'package:swp_project_web/screens/manage/manage_form/bloc/form_state.dart';
import 'package:swp_project_web/screens/manage/manage_form/detail_form.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class ManageFormScreen extends StatefulWidget {
  const ManageFormScreen({Key? key}) : super(key: key);

  @override
  State<ManageFormScreen> createState() => _ManageFormScreenState();
}

class _ManageFormScreenState extends State<ManageFormScreen> {
  final bool reloadWidget = false;
  List<FormsModel> listPost = [];
  final _bloc = FormBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllListPost());
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> _columns = [
      DataColumn(
        label: const Text('ID'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listPost.sort((a, b) => a.id!.compareTo(b.id as num));
            if (!ascending) {
              listPost = listPost.reversed.toList();
            }
          });
        },
      ),
      const DataColumn(
        label: Text('Ảnh bìa'),
      ),
      DataColumn(
        label: const Text('Tiêu đề'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listPost.sort((a, b) => a.title!.compareTo(b.title as String));
            if (!ascending) {
              listPost = listPost.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: const Text('Trạng thái'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listPost
                .sort((a, b) => a.postStatus!.compareTo(b.postStatus as num));
            if (!ascending) {
              listPost = listPost.reversed.toList();
            }
          });
        },
      ),
      const DataColumn(
        label: Text('Xem chi tiết'),
      ),
    ];
    return BlocConsumer<FormBloc, FormStates>(
      bloc: _bloc,
      listener: (context, state) async {
        if (state is FormLoading) {
          onLoading(context);
          return;
        } else if (state is FormSuccess) {
          Navigator.pop(context);
          listPost = state.list;
        } else if (state is FormError) {
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
        } else if (state is FormSuccess) {
          Navigator.pop(context);
          listPost = state.list;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15),
          //------------------------LIST-------------------------------
          child: PaginatedDataTable(
            horizontalMargin: 100,
            header: const Text('Danh sách đơn tạo đấu giá',
                style: TextStyle(fontWeight: FontWeight.bold)),
            columns: _columns,
            // ignore: deprecated_member_use
            dataRowHeight: 120,
            source: _DataSource(listPost, context),
            rowsPerPage: 4,
            availableRowsPerPage: const [4, 8],
          ),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final List<FormsModel> listPost;
  final BuildContext context;

  _DataSource(this.listPost, this.context);

  @override
  DataRow getRow(int index) {
    final post = listPost[index];
    return DataRow(cells: [
      DataCell(Text(post.id.toString())),
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
              image: (post.propertyImages!.isEmpty)
                  ? const AssetImage("assets/images/error_load_image.jpg")
                  : Image.network(post.propertyImages!.first).image,
            ),
          ),
        ),
      ),
      DataCell(Text(post.title.toString())),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: displayColor(post.postStatus),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          convertStatus(post.postStatus),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      )),
      DataCell(IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailForm(
                formModel: post,
              ),
            ),
          );
        },
        icon: const Icon(Icons.remove_red_eye_outlined),
        iconSize: 20,
        color: Colors.black.withOpacity(0.5),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listPost.length;

  @override
  int get selectedRowCount => 0;

  String convertStatus(int? postStatus) {
    switch (postStatus) {
      case 1:
        return 'Đợi duyệt';
      case 2:
        return 'Từ chối';
      case 3:
        return 'Đã duyệt';
      case 4:
        return 'Hoàn tất';
      default:
        return '';
    }
  }

  Color displayColor(int? postStatus) {
    switch (postStatus) {
      case 1:
        return const Color.fromARGB(255, 233, 155, 53);
      case 2:
        return const Color.fromARGB(255, 201, 38, 38);
      case 3:
        return const Color.fromARGB(255, 72, 176, 76);
      case 4:
        return const Color.fromARGB(255, 118, 128, 133);
      default:
        return Colors.white;
    }
  }
}
