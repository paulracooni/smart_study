import 'package:flutter/material.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsState.dart';

import 'ContentsItem.dart';

class ContentsSlider extends StatelessWidget {
  final String headerName;
  final List<String> itemNames;
  final ScrollController _scrollController = ScrollController();

  ContentsSlider({Key? key, required this.headerName, required this.itemNames})
      : super(key: key);

  bool isDesktop(context) {
    DisplayMode displayMode = MediaQuery
        .of(context)
        .displayMode;
    return displayMode == DisplayMode.DESKTOP;
  }

  @override
  Widget build(BuildContext context) =>
      ContentsBloc.consumer(
        builder: (BuildContext context, ContentsState state) {

          Widget scrollView = state is IndexUpdatedState
              ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            // isDesktop(context) ? Axis.vertical : Axis.horizontal,
            controller: _scrollController,
            child: Container(
              padding: isDesktop(context)
                  ? const EdgeInsets.only(bottom: 3.0)
                  : const EdgeInsets.only(right: 3.0),
              child: Flex(
                textBaseline: TextBaseline.alphabetic,
                direction: Axis.vertical,
                // isDesktop(context) ? Axis.vertical : Axis.horizontal,
                children: itemNames
                    .asMap()
                    .entries
                    .map((entry) {
                  int priority = entry.key;
                  String name = entry.value;

                  return ContentsItem(
                    name: name,
                    headerName: headerName,
                    priority: priority,
                  );
                }).toList(),
              ),
            ),
          )
              : const Center(child: CircularProgressIndicator());

          return Container(
            margin: isDesktop(context)
                ? const EdgeInsets.symmetric(horizontal: 3.0)
                : const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .colorScheme
                  .secondaryContainer,
              boxShadow: Effects.boxShadowEffect(context),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Flex(
                textBaseline: TextBaseline.alphabetic,
                // direction: isDesktop(context) ? Axis.vertical : Axis.horizontal,
                direction: Axis.vertical,
                // mainAxisAlignment: isDesktop(context)
                //     ? MainAxisAlignment.center
                //     : MainAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: isDesktop(context)
                        ? const EdgeInsets.only(bottom: 8)
                        : const EdgeInsets.only(top: 0),
                    // width: ContentsItemSize.width,
                    height: isDesktop(context) ? 75 : ContentsItemSize.height,
                    child: Center(
                      child: Text(
                        headerName,
                        style: isDesktop(context) ?
                        AppTextStyle.h6.copyWith(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ):AppTextStyle.h6.copyWith(
                          fontSize: 16,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child:scrollView,
                  ),
                ]),
          );
        },
      );
}
