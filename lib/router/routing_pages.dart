import 'package:flutter/material.dart';
import 'navigations/side_menu_item.dart';


class RoutingPages {
  static PageController pageController = PageController();

  static List<SideMenuItem> items = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: 'Contents',
        onTap: () => pageController.jumpToPage(0),
        icon: Icon(Icons.home),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Recordings',
        onTap: () => {},
        icon: Icon(Icons.bookmark),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Settings',
        onTap: () {},
        icon: Icon(Icons.settings),
      ),
    ];
}