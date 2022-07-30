import 'package:flutter/material.dart';
import 'package:smart_care/features/navigation/bloc/NavBloc.dart';
import 'package:smart_care/features/navigation/nav_item_left.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';

import 'nav_items.dart';

// ignore: must_be_immutable
class AnimatedNavLeft extends StatefulWidget {
  const AnimatedNavLeft({Key? key}) : super(key: key);

  @override
  State<AnimatedNavLeft> createState() => _AnimatedNavLeftState();
}

class _AnimatedNavLeftState extends State<AnimatedNavLeft> {
  DisplayMode get displayMode {
    return MediaQuery.of(context).displayMode;
  }

  double _widthSize(BuildContext context) {
    late double widthSize;
    switch (displayMode) {
      case DisplayMode.DESKTOP:
        widthSize = 210.0;
        break;
      case DisplayMode.TABELT:
        widthSize = 60.0;
        break;
      case DisplayMode.MOBILE:
        widthSize = 0.0;
        break;
      default:
        widthSize = 210.0;
    }
    return widthSize;
  }

  @override
  Widget build(BuildContext context) {
    NavBloc navBloc = NavBloc.read(context);

    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCirc,
      height: double.infinity,
      width: _widthSize(context),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (displayMode == DisplayMode.DESKTOP)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
                    child: Text(
                      "Smart Study",
                      style: AppTextStyle.h5.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                if (displayMode == DisplayMode.DESKTOP)
                  Divider(
                    indent: 5,
                    endIndent: 5,
                    thickness: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.2),
                  ),
                if (displayMode != DisplayMode.MOBILE)
                  ...navItems.map((navItem) {
                    return NavItemLeft(
                      icon: navItem.icon,
                      name: navItem.name,
                      navIndex: navItem.navIndex,
                    );
                  }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
