import 'package:flutter/material.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';

import 'ContentsItem.dart';

class ContentsSlider extends StatelessWidget {
  final String headerName;
  final List<String> names;
  final ScrollController _scrollController = ScrollController();

  ContentsSlider(
      {Key? key, required this.headerName, required this.names})
      : super(key: key);

  bool isDesktop(context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    return displayMode == DisplayMode.DESKTOP;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 3.0)
          : const EdgeInsets.fromLTRB(3.0, 0, 0, 3.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Flex(
          textBaseline: TextBaseline.alphabetic,
          direction: isDesktop(context) ? Axis.vertical : Axis.horizontal,
          children: [
            SizedBox(
              width: ContentsItemSize.width,
              height: isDesktop(context) ? 75 : ContentsItemSize.height,
              child: Center(
                child: Text(
                  headerName,
                  style: AppTextStyle.h6.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection:
                    isDesktop(context) ? Axis.vertical : Axis.horizontal,
                controller: _scrollController,
                child: Flex(
                  textBaseline: TextBaseline.alphabetic,
                  direction:
                      isDesktop(context) ? Axis.vertical : Axis.horizontal,
                  children: names.asMap().entries.map((entry) {
                    int priority = entry.key;
                    String name = entry.value;
                    return ContentsItem(
                      name: name,
                      priority: priority,
                      onTap: () {},
                    );
                  }).toList(),
                ),
              ),
            ),
          ]),
    );
  }
}
