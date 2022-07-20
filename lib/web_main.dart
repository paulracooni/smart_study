import 'package:flutter/material.dart';
import 'package:smart_care/features/contents/content_view.dart';

import 'router/navigations/side_menu_display_mode.dart';
import 'router/routing_pages.dart';
import 'router/navigations/side_menu.dart';
import 'router/navigations/side_menu_style.dart';

const _version = "dev 0.0.1";

class WebMain extends StatelessWidget {
  const WebMain({Key? key}) : super(key: key);

  Widget _sideTitle(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, bottom: 20),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 2),
            //@TODO: Row 그려지는 순서에 따라, 그림자가 가려지는데 이거 어떻게 처리하는지..?
            //일단은 어쩔 수 없이 Padding을 삽입함
            child: SideMenu(
              /// Page controller to manage a PageView
              controller: RoutingPages.pageController,

              /// Will shows on top of all items, it can be a logo or a Title text
              title: _sideTitle(context),

              /// Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
              footer: const Text(_version),

              /// Notify when display mode changed
              onDisplayModeChanged: (mode) {},

              /// List of SideMenuItem to show them on SideMenu
              items: RoutingPages.items,
              style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.auto,
                decoration: const BoxDecoration(),
                openSideMenuWidth: 200,
                compactSideMenuWidth: 46,
                hoverColor: colorScheme.onBackground.withOpacity(0.1),
                selectedColor: colorScheme.primary,
                selectedIconColor: colorScheme.onPrimary,
                unselectedIconColor: colorScheme.onBackground,
                backgroundColor: colorScheme.background,
                selectedTitleTextStyle: TextStyle(color: colorScheme.onPrimary),
                unselectedTitleTextStyle:
                    TextStyle(color: colorScheme.onBackground),
                iconSize: 20,
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: RoutingPages.pageController,
              children: const [
                ContentView(),
                Center(
                  child: Text('Recordings'),
                ),
                Center(
                  child: Text('Settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
