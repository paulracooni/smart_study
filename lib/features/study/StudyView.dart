import 'package:flutter/material.dart';
import 'package:smart_care/common_widgets/buttons/BackBtn.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/widgets/VideoView.dart';

import 'bloc/StudyState.dart';

class StudyView extends StatelessWidget {
  const StudyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isDesktop = displayMode == DisplayMode.DESKTOP;
    StudyBloc studyBloc = StudyBloc.read(context);

    return StudyBloc.consumer(
        builder: (BuildContext context, StudyState state) {
      return Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 80),
            color: Colors.red.withOpacity(.5),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              children: const [
                Expanded(
                  flex: 2,
                  child: VideoVew(),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text("Paragraph View"),
                  ),
                ),
              ],
            ),
          ),
          BackBtn(onTap: () {},),
        ],
      );
    });
  }
}
