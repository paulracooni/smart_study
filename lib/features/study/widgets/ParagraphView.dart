import 'package:flutter/material.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/models/StudyInfo.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudyBloc studyBloc = StudyBloc.read(context);
    return Container(
      height: 24,//status bar height
      width: studyBloc.cWidth,
      color: Colors.green,
    );
  }
}


class ParagraphView extends StatelessWidget {

  const ParagraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudyBloc studyBloc = StudyBloc.read(context);
    StudyInfo studyInfo = studyBloc.studyInfo;
    ScrollController paragraphController = studyBloc.paragraphController;
    studyBloc.screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: ListView(
            controller: paragraphController,
            children: studyInfo.paragraphs.map((paragraph) {
              return ListTile(title: Text(paragraph));
            }).toList(),
          ),
        ),
        // AnimatedBuilder(
        //   animation: paragraphController,
        //   builder: (BuildContext context, Widget child) {
        //     return ProgressBar();
        //   },
        // ),
      ],
    );
  }
}
