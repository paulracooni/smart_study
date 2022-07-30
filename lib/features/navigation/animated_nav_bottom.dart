import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';

import 'nav_item_bottom.dart';
import 'nav_items.dart';

class AnimatedNavBottom extends StatefulWidget {
  const AnimatedNavBottom({Key? key}) : super(key: key);

  @override
  State<AnimatedNavBottom> createState() => _AnimatedNavBottomState();
}

class _AnimatedNavBottomState extends State<AnimatedNavBottom> {
  DisplayMode get displayMode {
    return MediaQuery.of(context).displayMode;
  }

  double _heightSize(BuildContext context) {
    double heightSize = 70.0;
    switch (displayMode) {
      case DisplayMode.DESKTOP:
        heightSize = 0;
        break;
      case DisplayMode.TABELT:
        heightSize = 0;
        break;
      case DisplayMode.MOBILE:
        break;
    }
    return heightSize;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      duration: const Duration(milliseconds: 150),
      height: _heightSize(context),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: navItems.map((navItem) {
          return Expanded(
            child: NavItemBottom(
              icon: navItem.icon,
              name: navItem.name,
              navIndex: navItem.navIndex,
            ),
          );
        }).toList(),
      ),
    );
  }
}
