import 'package:flutter/material.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/models/StudyInfo.dart';
import 'package:smart_care/features/study/widgets/ParagraphItem.dart';

class ParagraphView extends StatelessWidget {

  const ParagraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudyBloc studyBloc = StudyBloc.read(context);
    StudyInfo studyInfo = studyBloc.studyInfo;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(

          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            controller: studyBloc.paragraphUtil.controller,
            children: studyInfo.paragraphs.asMap().entries.map((entry) {
              int priority = entry.key;
              String paragraph = entry.value;

              return ParagraphItem(
                priority: priority,
                paragraph: paragraph,
              );
            }).toList(),
          ),
        ),
        // progressBar(context),
      ],
    );
  }
}
