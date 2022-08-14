import 'package:flutter/material.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/bloc/StudyState.dart';
import 'package:smart_care/features/study/models/StudyInfo.dart';

class StudyHeader extends StatelessWidget {
  const StudyHeader({Key? key}) : super(key: key);

  String asDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget onStudyInfo() => StudyBloc.consumer(
        builder: (BuildContext context, StudyState state) {
          StudyBloc studyBloc = StudyBloc.read(context);
          TextStyle infoStyle = AppTextStyle.body.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          );
          return Row(
            children: [
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "기록: ${asDuration(state.tickPeriod).toString()}",
                    style: infoStyle,
                  ),
                  Text(
                    "진행: ${state.paragraphIndex + 1}/${studyBloc.paragraphUtil.itemsCount}",
                    style: infoStyle,
                  ),
                  // Text(
                  //   "다음까지: ${studyBloc.remainTime} 초",
                  //   style: infoStyle,
                  // ),
                ],
              ),
            ],
          );
        },
      );

  String _parseHeaderTitle(String studyTitle){
    List<String> headerTitles = studyTitle.split('/');
    if(headerTitles.length==1) {
      return studyTitle;
    }
    String headerTitle = headerTitles[2];
    return headerTitle.replaceAll(' ', '');
  }

  String _parseHeaderSubTitle(String studyTitle) {
    List<String> headerTitles = studyTitle.split('/');
    if(headerTitles.length==1) {
      return '';
    }
    String book = headerTitles[0].replaceAll(' ', '');
    String chapter = headerTitles[1].replaceAll(' ', '');
    return "$book - $chapter";
  }

  @override
  Widget build(BuildContext context) {
    return StudyBloc.consumer(
        builder: (BuildContext context, StudyState state) {
      StudyBloc studyBloc = StudyBloc.read(context);
      StudyInfo studyInfo = studyBloc.studyInfo;
      String headerTitle = _parseHeaderTitle(studyInfo.studyTitle);
      String headerSubTitle = _parseHeaderSubTitle(studyInfo.studyTitle);
      return Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        color: Theme.of(context).colorScheme.primary,
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    headerSubTitle,
                    style: AppTextStyle.body.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    headerTitle,
                    style: AppTextStyle.h5.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            if (state is! StudyInitState) onStudyInfo()
          ],
        ),
      );
    });
  }
}
