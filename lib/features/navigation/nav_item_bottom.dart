// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smart_care/features/navigation/bloc/NavBloc.dart';
import 'package:smart_care/features/navigation/bloc/NavEvent.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/display_mode.dart';

import 'nav_items.dart';

class NavItemBottom extends StatefulWidget {
  final icon;
  final name;
  final navIndex;

  const NavItemBottom(
      {Key? key,
        required this.icon,
        required this.name,
        required this.navIndex})
      : super(key: key);

  @override
  State<NavItemBottom> createState() => _NavItemBottomState();
}

class _NavItemBottomState extends State<NavItemBottom> {
  bool isHovered = false;

  DisplayMode get displayMode {
    return MediaQuery.of(context).displayMode;
  }

  Color _setColorIconText(NavBloc bloc) {
    Color colorIconText =
    Theme.of(context).colorScheme.onPrimary.withOpacity(0.4);

    if (bloc.navModel.navIndex == widget.navIndex) {
      colorIconText = Theme.of(context).colorScheme.onPrimary;
    } else if (isHovered) {
      colorIconText = Theme.of(context).colorScheme.onPrimary.withOpacity(0.7);
    }
    return colorIconText;
  }

  @override
  Widget build(BuildContext context) {
    NavBloc bloc = NavBloc.read(context);

    return InkWell(
      onTap: () {
        bloc.add(UpdateNavIndexEvent(widget.navIndex));
        setState(() {});
      },
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: double.infinity,
        width: 60,
        margin: displayMode == DisplayMode.DESKTOP
            ?const EdgeInsets.fromLTRB(20, 5, 0, 5)
            :const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Icon(
                widget.icon,
                size: 32,
                color: _setColorIconText(bloc),
              ),
            ),
            Expanded(
              flex:1,
              child: Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.button.copyWith(
                  fontSize: 14,
                  color: _setColorIconText(bloc),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
