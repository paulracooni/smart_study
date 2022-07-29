import 'package:flutter/material.dart';
import 'package:smart_care/common_widgets/buttons/back_btn.dart';
import 'package:smart_care/constants/content_datas.dart';
import 'package:smart_care/features/study/video_screen.dart';

import 'control_view.dart';
import 'sentence_slider.dart';
import 'study_controller.dart';

class StudyView extends StatefulWidget {
  const StudyView({Key? key}) : super(key: key);

  @override
  State<StudyView> createState() => _StudyViewState();
}

class _StudyViewState extends State<StudyView> {
  late StudyController studyController;

  @override
  void initState() {
    super.initState();

    studyController = StudyController(sentencesLength: sentences.length);
    if (mounted) {
      // set controller SideMenuItem page controller callback
      studyController.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 80.0,
            vertical: 40.0,
          ),
          width: double.infinity,
          height: double.infinity,
          child: Flex(
            direction:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                        child: Center(
                      child: VideoScreen(
                        controller: studyController,
                      ),
                    )),
                    ControlView(controller: studyController),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SentenceSlider(
                  sentences: sentences,
                ),
              ),
            ],
          ),
        ),
        const BackBtn(),
      ]),
    );
  }
}
