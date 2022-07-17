import 'package:flutter/material.dart';

import '../../constants/design/effects.dart';
import 'global.dart';
import 'side_menu_display_mode.dart';
import 'side_menu_item.dart';
import 'side_menu_style.dart';
import 'side_menu_toggle.dart';


class SideMenu extends StatefulWidget {
  /// Page controller to control [PageView] widget
  final PageController controller;

  /// List of [SideMenuItem] to show them on [SideMenu]
  final List<SideMenuItem> items;

  /// Title widget will shows on top of all items,
  /// it can be a logo or a Title text
  final Widget? title;

  /// Footer widget will show on bottom of [SideMenu]
  /// when [displayMode] was SideMenuDisplayMode.open
  final Widget? footer;

  /// [SideMenu] can be configured by this
  final SideMenuStyle? style;

  /// Show toggle button to switch between open and compact display mode
  /// If the display mode is auto, this button will not be displayed
  final bool? showToggle;

  /// Notify when [SideMenuDisplayMode] changed
  final ValueChanged<SideMenuDisplayMode>? onDisplayModeChanged;

  /// Duration of [displayMode] toggling duration
  final Duration? displayModeToggleDuration;

  /// ### Easy Sidemenu widget
  ///
  /// Sidemenu is a menu that is usually located
  /// on the left or right of the page and can used for navigation
  const SideMenu({
    Key? key,
    required this.items,
    required this.controller,
    this.title,
    this.footer,
    this.style,
    this.showToggle,
    this.onDisplayModeChanged,
    this.displayModeToggleDuration,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  double _currentWidth = 0;
  late bool showToggle;

  @override
  void initState() {
    super.initState();
    showToggle = widget.showToggle ?? false;
  }

  void _notifyParent() {
    if (widget.onDisplayModeChanged != null) {
      widget.onDisplayModeChanged!(Global.displayModeState.value);
    }
  }

  /// Set [SideMenu] width according to displayMode and notify parent widget
  double _widthSize(SideMenuDisplayMode mode, BuildContext context) {
    if (mode == SideMenuDisplayMode.auto) {
      if (MediaQuery
          .of(context)
          .size
          .width > 600 &&
          Global.displayModeState.value != SideMenuDisplayMode.open) {
        Global.displayModeState.change(SideMenuDisplayMode.open);
        _notifyParent();
        return Global.style.openSideMenuWidth ?? 300;
      }
      if (MediaQuery
          .of(context)
          .size
          .width <= 600 &&
          Global.displayModeState.value != SideMenuDisplayMode.compact) {
        Global.displayModeState.change(SideMenuDisplayMode.compact);
        _notifyParent();
        return Global.style.compactSideMenuWidth ?? 50;
      }
      return _currentWidth;
    } else if (mode == SideMenuDisplayMode.open &&
        Global.displayModeState.value != SideMenuDisplayMode.open) {
      Global.displayModeState.change(SideMenuDisplayMode.open);
      _notifyParent();
      return Global.style.openSideMenuWidth ?? 300;
    }
    if (mode == SideMenuDisplayMode.compact &&
        Global.displayModeState.value != SideMenuDisplayMode.compact) {
      Global.displayModeState.change(SideMenuDisplayMode.compact);
      _notifyParent();
      return Global.style.compactSideMenuWidth ?? 50;
    }
    return _currentWidth;
  }

  Decoration _decoration(SideMenuStyle? menuStyle) {
    if (menuStyle == null || menuStyle.decoration == null) {
      return BoxDecoration(
        color: Global.style.backgroundColor,
      );
    } else {
      if (menuStyle.backgroundColor != null) {
        menuStyle.decoration =
            menuStyle.decoration!.copyWith(color: menuStyle.backgroundColor);
      }
      return menuStyle.decoration!.copyWith(
        boxShadow: Effects.boxShadowEffect(context),
      );
    }
  }

  Duration _toggleDuration() {
    return widget.displayModeToggleDuration ??
        const Duration(milliseconds: 350);
  }

  @override
  Widget build(BuildContext context) {
    Global.controller = widget.controller;
    widget.items.sort((a, b) => a.priority.compareTo(b.priority));
    Global.style = widget.style ?? SideMenuStyle();
    _currentWidth = _widthSize(
        Global.style.displayMode ?? SideMenuDisplayMode.auto, context);

    return AnimatedContainer(
      duration: _toggleDuration(),
      width: _currentWidth,
      height: MediaQuery
          .of(context)
          .size
          .height,
      decoration: _decoration(widget.style),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                if (Global.style.displayMode == SideMenuDisplayMode.compact &&
                    showToggle)
                  const SizedBox(height: 42),
                if (Global.displayModeState.value == SideMenuDisplayMode.open && widget.title != null)
                  widget.title!,
                ...widget.items,
              ],
            ),
          ),
          if (widget.footer != null &&
              Global.displayModeState.value != SideMenuDisplayMode.compact)
            Align(alignment: Alignment.bottomCenter, child: widget.footer!),
          if (Global.style.displayMode != SideMenuDisplayMode.auto &&
              showToggle)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                  Global.displayModeState.value == SideMenuDisplayMode.open
                      ? 0
                      : 4,
                  vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SideMenuToggle(
                    onTap: () {
                      if (Global.displayModeState.value ==
                          SideMenuDisplayMode.compact) {
                        setState(() {
                          Global.style.displayMode = SideMenuDisplayMode.open;
                        });
                      } else if (Global.displayModeState.value ==
                          SideMenuDisplayMode.open) {
                        setState(() {
                          Global.style.displayMode =
                              SideMenuDisplayMode.compact;
                        });
                      }
                    },
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
