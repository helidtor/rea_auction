import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swp_project_web/models/response/property_model.dart';
import 'package:swp_project_web/screens/manage/manage_property/bloc/list_property_bloc.dart';
import 'package:swp_project_web/screens/manage/manage_property/bloc/list_property_event.dart';
import 'package:swp_project_web/screens/manage/manage_property/bloc/list_property_state.dart';
import 'package:swp_project_web/widgets/input/text_content.dart';
import 'package:swp_project_web/widgets/others/loading.dart';
import 'package:toastification/toastification.dart';

class ManagePropertyScreen extends StatefulWidget {
  const ManagePropertyScreen({Key? key}) : super(key: key);

  @override
  State<ManagePropertyScreen> createState() => _ManagePropertyScreenState();
}

class _ManagePropertyScreenState extends State<ManagePropertyScreen> {
  List<PropertyModel> listProperty = [];
  final _bloc = PropertyListBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetAllListProperty());
  }

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> _columns = [
      DataColumn(
        label: const Text('ID'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listProperty.sort((a, b) => a.id!.compareTo(b.id as num));
            if (!ascending) {
              listProperty = listProperty.reversed.toList();
            }
          });
        },
      ),
      const DataColumn(
        label: Text('Ảnh tài sản'),
      ),
      DataColumn(
        label: const Text('Tên tài sản'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listProperty.sort((a, b) => a.name!.compareTo(b.name as String));
            if (!ascending) {
              listProperty = listProperty.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: const Text('Diện tích'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listProperty.sort((a, b) => a.area!.compareTo(b.area as num));
            if (!ascending) {
              listProperty = listProperty.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: const Text('Khả dụng'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listProperty.sort(
              (a, b) {
                // Sắp xếp theo giá trị boolean của trường isAvailable
                if (ascending) {
                  return a.isAvailable == b.isAvailable
                      ? 0
                      : (a.isAvailable! ? 1 : -1);
                } else {
                  return a.isAvailable == b.isAvailable
                      ? 0
                      : (a.isAvailable! ? -1 : 1);
                }
              },
            );
          });
        },
      ),
      DataColumn(
        label: const Text('Địa chỉ'),
        onSort: (columnIndex, ascending) {
          setState(() {
            listProperty
                .sort((a, b) => a.street!.compareTo(b.street as String));
            if (!ascending) {
              listProperty = listProperty.reversed.toList();
            }
          });
        },
      ),
      const DataColumn(
        label: Text('Xem chi tiết'),
      ),
    ];
    return BlocConsumer<PropertyListBloc, PropertyListState>(
      bloc: _bloc,
      listener: (context, state) async {
        if (state is PropertyListLoading) {
          onLoading(context);
          return;
        } else if (state is PropertyListSuccess) {
          Navigator.pop(context);
          listProperty = state.list;
        } else if (state is PropertyListError) {
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
            horizontalMargin: 20,
            header: const Text('Danh sách tài sản',
                style: TextStyle(fontWeight: FontWeight.bold)),
            columns: _columns,
            // ignore: deprecated_member_use
            dataRowHeight: 120,
            source: _DataSource(listProperty),
            rowsPerPage: 4,
            availableRowsPerPage: const [4, 8],
          ),
        );
      },
    );
  }
}

class _DataSource extends DataTableSource {
  final List<PropertyModel> listProperty;

  _DataSource(this.listProperty);

  @override
  DataRow getRow(int index) {
    final property = listProperty[index];
    return DataRow(cells: [
      DataCell(Text(property.id.toString())),
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
              image: (property.images!.first.isEmpty)
                  ? const AssetImage("assets/images/error_load_image.jpg")
                  : Image.network(property.images!.first).image,
            ),
          ),
        ),
      ),
      DataCell(Text(property.name.toString())),
      DataCell(Text('${property.area.toString()}m\u00b2')),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: displayColor(property.isAvailable),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          convertStatus(property.isAvailable),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      )),
      DataCell(
        Text(
            '${property.street}, ${property.ward}, ${property.district}, ${property.city}'),
      ),
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
  int get rowCount => listProperty.length;

  @override
  int get selectedRowCount => 0;

  String convertStatus(bool? isAvailbale) {
    if (isAvailbale == true) {
      return 'Có';
    } else {
      return 'Không';
    }
  }

  Color displayColor(bool? isAvailbale) {
    if (isAvailbale == true) {
      return const Color.fromARGB(255, 72, 176, 76);
    } else {
      return const Color.fromARGB(255, 118, 128, 133);
    }
  }
}
