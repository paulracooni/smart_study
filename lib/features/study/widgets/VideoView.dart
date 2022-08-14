import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/bloc/StudyState.dart';
import 'package:smart_care/features/study/models/StudyInfo.dart';

import 'StudyController.dart';
import 'VideoScreen.dart';

class VideoVew extends StatelessWidget {
  const VideoVew({Key? key}) : super(key: key);

  Widget layout(BuildContext context, {required Widget child}) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isDesktop = displayMode == DisplayMode.DESKTOP;
    return Container(
      // margin: isDesktop
      //     ? const EdgeInsets.only(right: 5)
      //     : const EdgeInsets.only(bottom: 5),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: child,
    );
  }

  String asDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }


  Widget header(BuildContext context) {
    return StudyBloc.consumer(
        builder: (BuildContext context, StudyState state) {
          StudyBloc studyBloc = StudyBloc.read(context);
          StudyInfo studyInfo = studyBloc.studyInfo;
      return Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Center(
              child: Text(
                studyInfo.studyTitle,
                style: AppTextStyle.h5.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Text(
              state is! StudyInitState? asDuration(state.tickPeriod).toString() : "",
              style: AppTextStyle.h5.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return layout(
      context,
      child: Column(
        children: [
          header(context),
          Expanded(
              child: Center(
            child: BlocBuilder<StudyBloc, StudyState>(
              buildWhen: (previous, current) {
                return false;
              },
              builder: (BuildContext context, StudyState state) {
                return const VideoScreen();
              },
            ),
          )),
          const StudyController(),
        ],
      ),
    );
  }
}
