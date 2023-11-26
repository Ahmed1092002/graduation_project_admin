import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class MainScrean extends StatefulWidget {
  const MainScrean({Key? key}) : super(key: key);

  @override
  _MainScreanState createState() => _MainScreanState();
}

class _MainScreanState extends State<MainScrean> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  List<SideMenuItem> items = [
    SideMenuItem(

      title: 'Dashboard',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);

      },
      icon: Icon(Icons.home),
      badgeContent: Text(
        '3',
        style: TextStyle(color: Colors.white),
      ),
    ),
    SideMenuItem(
      title: 'Settings',
      onTap: (index, sideMenu) {
        sideMenu.changePage(index);
      },
      icon: Icon(Icons.settings),
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

      body:Row(
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
                  backgroundColor: Colors.grey,
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
                  toggleColor: Colors.black54
              ),
              controller: sideMenu,



              onDisplayModeChanged: (mode) {
                print(mode);
              },
              // List of SideMenuItem to show them on SideMenu
              items: items,
            ),
          ),
          Expanded(
            flex: 5,
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
