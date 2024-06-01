import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project_admin/views/dashboard_view/dashboard_view.dart';
import 'package:graduation_project_admin/views/job_view/job_managment.dart';
import 'package:graduation_project_admin/views/manage_user_view/manage_user_view.dart';
import 'package:graduation_project_admin/views/recieve_feedback_view/Recieve_Requst.dart';

class MainScrean extends StatefulWidget {
  const MainScrean({Key? key}) : super(key: key);

  @override
  _MainScreanState createState() => _MainScreanState();
}

class _MainScreanState extends State<MainScrean> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  List<SideMenuItem> items = [
    //todo : احمد
    SideMenuItem(
      title: 'Dashboard',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);
      },
      icon: Icon(Icons.home),
    ),
    SideMenuItem(
      title: 'Manage jobs',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);
      },
      icon: Icon(Icons.work),
    ),

    // todo:احمد
    SideMenuItem(
      title: 'Manage users',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);
      },
      icon: Icon(Icons.people),
    ),

    //todo:صباح
    SideMenuItem(
      title: 'Legal Content',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);
      },
      icon: Icon(Icons.content_paste),
    ),
    SideMenuItem(
      title: 'Culture Content',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);
      },
      icon: Icon(Icons.content_paste),
    ),

    //todo: فاطمة
    SideMenuItem(
      title: 'Receive feedback',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);
      },
      icon: Icon(Icons.feedback),
    ),
    SideMenuItem(
      title: 'Requests of Helping',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);
      },
      icon: Icon(Icons.help),
    ),

    SideMenuItem(
      title: 'Exit',
      onTap: (index, _) {},
      icon: Icon(Icons.exit_to_app),
    ),
  ];
  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: SideMenu(
            style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.auto,
                decoration: BoxDecoration(),
                openSideMenuWidth: 200,
                compactSideMenuWidth: 40,
                hoverColor: Colors.blue[100],
                selectedColor: Colors.lightBlue,
                selectedIconColor: Colors.white,
                unselectedIconColor: Colors.black54,
                backgroundColor: Color(0xFF0C7AB7),
                selectedTitleTextStyle: TextStyle(color: Colors.white),
                unselectedTitleTextStyle: TextStyle(color: Colors.black54),
                iconSize: 20,
                itemBorderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                showTooltip: true,
                itemHeight: 50.0,
                itemInnerSpacing: 8.0,
                itemOuterPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                toggleColor: Colors.black54),
            controller: sideMenu,
            collapseWidth: 40,
            displayModeToggleDuration: Duration(milliseconds: 300),
            onDisplayModeChanged: (mode) {
              print(mode);
            },
            // List of SideMenuItem to show them on SideMenu
            items: items,
          ),
        ),

        ////////////////////////////////////////////////////////////////

        Expanded(
          flex: 5,
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              DashboardView(),
              JobView(),
              ManageUserView(),
              RecieveRequst(),
            ],
          ),
        ),
      ],
    ));
  }
}
