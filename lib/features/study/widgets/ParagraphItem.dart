import 'package:flutter/material.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/bloc/StudyState.dart';

class ParagraphItem extends StatelessWidget {
  final String paragraph;
  final int priority;

  const ParagraphItem(
      {Key? key, required this.paragraph, required this.priority})
      : super(key: key);

  @override
  Widget build(BuildContext context) => StudyBloc.consumer(
        builder: (BuildContext context, StudyState state) {
          // print(state);
          bool selected = state.paragraphIndex == priority;
          double height = StudyBloc.read(context).paragraphUtil.itemHeight;
          DisplayMode displayMode = MediaQuery.of(context).displayMode;
          bool isMobile = displayMode == DisplayMode.MOBILE;

          return AnimatedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            height: height,
            color: selected
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.background,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: Text(
              paragraph,
              textAlign: TextAlign.center,
              style: selected
                  ? AppTextStyle.body.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: isMobile ? 20 : 32,
                      fontWeight: FontWeight.w900,
                    )
                  : AppTextStyle.body.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                      fontSize: isMobile ? 16 : 26,
                      fontWeight: FontWeight.w300,
                    ),
            ),
          );
        },
      );
}
