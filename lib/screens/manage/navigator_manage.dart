import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:swp_project_web/screens/manage/manage_form/manage_form_screen.dart';
import 'package:swp_project_web/screens/manage/manage_auction/manage_post_screen.dart';
import 'package:swp_project_web/screens/manage/manage_property/manage_property_screen.dart';
import 'package:swp_project_web/screens/manage/manage_user/manage_user_screen.dart';
import 'package:swp_project_web/screens/manage/settings/setting_screen.dart';
import 'package:swp_project_web/theme/pallete.dart';

class NavigatorManage extends StatefulWidget {
  const NavigatorManage({super.key});

  @override
  State<NavigatorManage> createState() => _NavigatorManageState();
}

class _NavigatorManageState extends State<NavigatorManage> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSelectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return const ManageUserScreen();
      case 1:
        return const ManageFormScreen();
      case 2:
        return const ManagePostScreen();
      case 3:
        return const ManagePropertyScreen();
      case 4:
        return const SettingScreen();
      default:
        return Container(); // Trả về một widget mặc định nếu _selectedIndex không hợp lệ
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainBackground,
      body: Row(
        children: [
          SidebarX(
            controller: SidebarXController(selectedIndex: _selectedIndex),
            animationDuration: 200.ms,
            theme: SidebarXTheme(
              itemTextPadding: const EdgeInsets.only(left: 30),
              iconTheme: const IconThemeData(
                  color: Color.fromARGB(178, 255, 255, 255)),
              textStyle: const TextStyle(
                color: Colors.white70,
              ),
              hoverColor: const Color.fromARGB(255, 206, 152, 161),
              hoverTextStyle: const TextStyle(
                color: Color.fromARGB(255, 230, 225, 225),
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              selectedIconTheme: const IconThemeData(color: Colors.white),
              selectedItemDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 107, 127),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromARGB(255, 208, 136, 166)
                      .withOpacity(0.37),
                ),
              ),
              decoration: BoxDecoration(
                color: Pallete.sideBarColor,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(15),
            ),
            extendedTheme: const SidebarXTheme(
              margin: EdgeInsets.all(10),
              width: 190,
            ),
            items: [
              SidebarXItem(
                icon: Icons.supervised_user_circle,
                label: 'Tài khoản',
                onTap: () => _onItemSelected(0),
              ),
              SidebarXItem(
                icon: Icons.format_align_center,
                label: 'Đơn tạo đấu giá',
                onTap: () => _onItemSelected(1),
              ),
              SidebarXItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Cuộc đấu giá',
                onTap: () => _onItemSelected(2),
              ),
              SidebarXItem(
                icon: Icons.home,
                label: 'Tài sản',
                onTap: () => _onItemSelected(3),
              ),
              SidebarXItem(
                icon: Icons.settings,
                label: 'Cài đặt',
                onTap: () => _onItemSelected(4),
              ),
            ],
            footerDivider: const Divider(color: Colors.white70, height: 2),
            headerBuilder: (context, extended) {
              return const SizedBox(
                height: 30,
              );
            },
          ),
          Expanded(
            child: _buildSelectedWidget(),
          ),
        ],
      ),
    );
  }
}
