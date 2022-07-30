// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:smart_care/features/navigation/bloc/NavBloc.dart';
import 'package:smart_care/features/navigation/bloc/NavEvent.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/display_mode.dart';

import 'nav_items.dart';

class NavItemLeft extends StatefulWidget {
  final icon;
  final name;
  final navIndex;

  const NavItemLeft(
      {Key? key,
      required this.icon,
      required this.name,
      required this.navIndex})
      : super(key: key);

  @override
  State<NavItemLeft> createState() => _NavItemLeftState();
}

class _NavItemLeftState extends State<NavItemLeft> {
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
        height: 60.0,
        width: double.infinity,
        margin: displayMode == DisplayMode.DESKTOP
          ?const EdgeInsets.fromLTRB(20, 5, 0, 5)
          :const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: displayMode == DisplayMode.DESKTOP
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Expanded(
              flex:1,
              child: Icon(
                widget.icon,
                size: 32,
                color: _setColorIconText(bloc),
              ),
            ),
            if (displayMode == DisplayMode.DESKTOP)
              Expanded(
                flex:5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.button.copyWith(
                      fontSize: 18,
                      color: _setColorIconText(bloc),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
