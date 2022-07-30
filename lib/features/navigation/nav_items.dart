import 'package:flutter/material.dart';

import 'nav_item_left.dart';

class NavItem {
  final IconData icon;
  final String name;
  final int navIndex;

  const NavItem(
      {required this.icon, required this.name, required this.navIndex});
}

const List<NavItem> navItems = [
  NavItem(
    icon: Icons.home,
    name: "Study",
    navIndex: 0,
  ),
  NavItem(
    icon: Icons.bookmark,
    name: "Recordings",
    navIndex: 1,
  ),
  NavItem(
    icon: Icons.person,
    name: "My Page",
    navIndex: 2,
  ),
];