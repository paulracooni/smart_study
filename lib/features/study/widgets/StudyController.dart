import 'package:flutter/material.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/bloc/StudyState.dart';

class StudyController extends StatelessWidget {
  const StudyController({Key? key}) : super(key: key);

  // StudyInitState
  // StudyReadyState
  // StudyStartState
  // StudyPauseState
  // StudyCompleteState

  @override
  Widget build(BuildContext context) =>
      StudyBloc.consumer(builder: (BuildContext context, StudyState state) {
        return Container();
      });
}
