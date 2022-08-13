import 'package:flutter/material.dart';
import 'package:smart_care/common_widgets/buttons/BackBtn.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/study/widgets/VideoView.dart';

import 'bloc/StudyBloc.dart';
import 'bloc/StudyEvent.dart';
import 'models/StudyInfo.dart';
import 'widgets/ParagraphView.dart';

class StudyView extends StatelessWidget {

  const StudyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isDesktop = displayMode == DisplayMode.DESKTOP;
    StudyBloc studyBloc = StudyBloc.read(context);

    // final studyInfo = ModalRoute.of(context)!.settings.arguments as StudyInfo;
    // print(studyInfo);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          color: Colors.red.withOpacity(.5),
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            children: [
              Expanded(
                flex: 2,
                child: VideoVew(),
              ),
              Expanded(
                flex: 3,
                child: ParagraphView(),
              ),
            ],
          ),
        ),
        BackBtn(
          onTap: () {
            studyBloc.add(StudyStopEvent());
          },
        ),
      ],
    );
  }
}
