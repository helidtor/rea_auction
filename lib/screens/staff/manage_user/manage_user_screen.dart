import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/models/response/user_profile_model.dart';
import 'package:swp_project_web/screens/staff/manage_user/bloc/list_user_bloc.dart';
import 'package:swp_project_web/screens/staff/manage_user/bloc/list_user_event.dart';
import 'package:swp_project_web/screens/staff/manage_user/bloc/list_user_state.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class ManageUserScreen extends StatefulWidget {
  const ManageUserScreen({Key? key}) : super(key: key);

  @override
  State<ManageUserScreen> createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  List<UserProfileModel> listUser = [];
  final _bloc = UserListBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllListUser());
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> _columns = [
      DataColumn(
        label: const Text('ID'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listUser.sort((a, b) => a.id!.compareTo(b.id as num));
            if (!ascending) {
              listUser = listUser.reversed.toList();
            }
          });
        },
      ),
      const DataColumn(
        label: Text('Ảnh đại diện'),
      ),
      DataColumn(
        label: const Text('Họ'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listUser
                .sort((a, b) => a.firstName!.compareTo(b.firstName as String));
            if (!ascending) {
              listUser = listUser.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: const Text('Tên'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listUser
                .sort((a, b) => a.lastName!.compareTo(b.lastName as String));
            if (!ascending) {
              listUser = listUser.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: const Text('Email'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listUser.sort((a, b) => a.email!.compareTo(b.email as String));
            if (!ascending) {
              listUser = listUser.reversed.toList();
            }
          });
        },
      ),
      const DataColumn(
        label: Text('Trạng thái'),
      ),
      const DataColumn(
        label: Text('Xem chi tiết'),
      ),
    ];
    return BlocConsumer<UserListBloc, UserListState>(
      bloc: _bloc,
      listener: (context, state) async {
        if (state is UserListLoading) {
          onLoading(context);
          return;
        } else if (state is UserListSuccess) {
          Navigator.pop(context);
          listUser = state.list;
        } else if (state is UserListError) {
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
        return Padding(
          padding: const EdgeInsets.all(15),
          //------------------------LIST-------------------------------
          child: PaginatedDataTable(
            horizontalMargin: 100,
            header: const Text('Danh sách user',
                style: TextStyle(fontWeight: FontWeight.bold)),
            columns: _columns,
            // ignore: deprecated_member_use
            dataRowHeight: 70,
            source: _DataSource(listUser),
            rowsPerPage: 7,
            availableRowsPerPage: const [7, 10],
          ),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final List<UserProfileModel> listUser;

  _DataSource(this.listUser);

  @override
  DataRow getRow(int index) {
    final user = listUser[index];
    return DataRow(cells: [
      DataCell(Text(user.id.toString())),
      DataCell(
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(253, 255, 255, 255),
            ),
            color: const Color.fromARGB(253, 255, 255, 255),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: (user.avatarUrl == null)
                  ? const AssetImage("assets/images/error_load_image.jpg")
                  : Image.network(user.avatarUrl!).image,
            ),
          ),
        ),
      ),
      DataCell(Text(user.firstName.toString())),
      DataCell(Text(user.lastName.toString())),
      DataCell(Text(user.email.toString())),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: displayColor(user.isActive),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          convertStatus(user.isActive),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      )),
      DataCell(IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.remove_red_eye_outlined,
          color: Colors.black.withOpacity(0.5),
        ),
        iconSize: 20,
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listUser.length;

  @override
  int get selectedRowCount => 0;

  String convertStatus(bool? isActive) {
    switch (isActive) {
      case true:
        return 'Hoạt động';
      case false:
        return 'Vô hiệu hóa';
      default:
        return '';
    }
  }

  Color displayColor(bool? isActive) {
    switch (isActive) {
      case true:
        return const Color.fromARGB(255, 72, 176, 76);
      case false:
        return const Color.fromARGB(255, 118, 128, 133);
      default:
        return Colors.white;
    }
  }
}
