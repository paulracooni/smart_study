import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_care/router/navigations/side_menu.dart';
import 'package:smart_care/router/routing_pages.dart';

import 'router/navigations/global.dart';
import 'router/navigations/side_menu_display_mode.dart';
import 'router/navigations/side_menu_style.dart';

const _seedColor = Color(0x0E4DA4FD);
const _version = "dev 0.0.1";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return MaterialApp(
      title: 'Smart Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: _seedColor, brightness: Brightness.light),
        textTheme: GoogleFonts.notoSansNKoTextTheme(theme.textTheme),
      ),
      home: Scaffold(
          body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            // Page controller to manage a PageView
            controller: RoutingPages.pageController,
            // Will shows on top of all items, it can be a logo or a Title text
            title: Padding(
              padding: const EdgeInsets.only(left:10, top:5, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Smart English",
                    style: TextStyle(
                      fontSize: 24,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "Student 1",
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                  )
                ],
              ),
            ),
            // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
            footer: Text('dev 0.0.1'),
            // Notify when display mode changed
            onDisplayModeChanged: (mode) {},
            // List of SideMenuItem to show them on SideMenu
            items: RoutingPages.items,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              decoration: BoxDecoration(),
              openSideMenuWidth: 200,
              compactSideMenuWidth: 46,
              hoverColor: colorScheme.onBackground.withOpacity(0.5),
              selectedColor: colorScheme.primary,
              selectedIconColor: colorScheme.onBackground,
              unselectedIconColor: colorScheme.secondary,
              backgroundColor: colorScheme.background,
              selectedTitleTextStyle: TextStyle(color: colorScheme.onPrimary),
              unselectedTitleTextStyle: TextStyle(color: colorScheme.secondary),
              iconSize: 20,
            ),
          ),
          Expanded(
            child: PageView(
              controller: RoutingPages.pageController,
              children: [
                Container(
                  child: Center(
                    child: Text('Dashboard'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('Settings'),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
