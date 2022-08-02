// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/effects.dart';

class ContentItem extends StatefulWidget {
  /// Element widget of [ContentSelector]
  ///
  /// item name
  // ignore: prefer_typing_uninitialized_variables
  final String item;

  /// A function that call when tap on [SideMenuItem]
  final Function(int) onTap;

  /// Priority of item to show on [SideMenu], lower value is displayed at the top
  ///
  /// * Start from 0
  /// * This value should be unique
  /// * This value used for page controller index
  final int priority;

  final ValueNotifier<int> controller;

  const ContentItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.priority,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContentItem> createState() => _ContentItemState();
}

class _ContentItemState extends State<ContentItem> {
  bool isHovered = false;
  int currentPage = 0;

  T? _nonNullableWrap<T>(T? value) => value;
  @override
  void initState() {
    super.initState();
    _nonNullableWrap(WidgetsBinding.instance)!.addPostFrameCallback((timeStamp) {
      // set initialPage
      setState(() {
        currentPage = widget.controller.value;
      });
      if (mounted) {
        // set controller SideMenuItem page controller callback
        widget.controller.addListener(() {
          currentPage = widget.controller.value;
          setState(() {});
        });
      }
    });
  }
  Color _setColor() {
    if (widget.priority == currentPage) {
      return Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8);
    } else if (isHovered) {
      return Theme.of(context).colorScheme.onBackground.withOpacity(0.2);
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.controller.value = widget.priority;
        currentPage = widget.controller.value;
        setState(() {});
      } ,
      onHover: (value) {
        setState(() {isHovered = value;});
      },
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          padding: const EdgeInsets.only(
              left: 5.0, right: 20.0, top: 5.0, bottom: 5),
          decoration: BoxDecoration(
              color: _setColor(),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                if (widget.priority == currentPage)
                  ...Effects.boxShadowEffect(context)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 28,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(widget.item,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
