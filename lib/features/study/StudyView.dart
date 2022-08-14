import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/common_widgets/buttons/BackBtn.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/study/bloc/StudyState.dart';
import 'package:smart_care/features/study/widgets/StudyController.dart';
import 'package:smart_care/features/study/widgets/StudyHeader.dart';
import 'package:smart_care/features/study/widgets/VideoView.dart';

import 'bloc/StudyBloc.dart';
import 'bloc/StudyEvent.dart';
import 'models/StudyInfo.dart';
import 'widgets/ParagraphView.dart';
import 'widgets/VideoScreen.dart';

class StudyView extends StatelessWidget {
  const StudyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isDesktop = displayMode == DisplayMode.DESKTOP;
    StudyBloc studyBloc = StudyBloc.read(context);

    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Flex(
            // direction: isDesktop ? Axis.horizontal : Axis.vertical,
            direction: Axis.vertical,
            children: [
              const StudyHeader(),
              Expanded(
                flex: 2,
                child: Center(
                  child: BlocBuilder<StudyBloc, StudyState>(
                    buildWhen: (previous, current) {
                      return false;
                    },
                    builder: (BuildContext context, StudyState state) {
                      return const VideoScreen();
                    },
                  ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: ParagraphView(),
              ),
              const StudyController(),
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
