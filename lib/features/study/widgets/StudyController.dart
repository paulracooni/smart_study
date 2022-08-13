import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/btn_styles.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/bloc/StudyEvent.dart';
import 'package:smart_care/features/study/bloc/StudyState.dart';

class StudyController extends StatelessWidget {
  const StudyController({Key? key}) : super(key: key);

  Widget layout(BuildContext context, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: child,
    );
  }

  Widget controlBtn(
      {required void Function() onPressed,
      required ButtonStyle style,
      required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }

  Widget btnStudyModeSelector(BuildContext context, StudyState state) {
    StudyBloc studyBloc = StudyBloc.read(context);
    return Row(
      children: [
        if (state is! StudyStartState)
          controlBtn(
            onPressed: () {
              studyBloc.add(ClickSeqRandBtnEvent());
            },
            style: BtnStyles(context).onPrimary,
            child: Text(state.seqRandMode),
          ),
        if (state is! StudyStartState)
          controlBtn(
            onPressed: () {
              studyBloc.add(ClickSpeedBtnEvent());
            },
            style: BtnStyles(context).onPrimary,
            child: Text("Speed x${state.speed}"),
          ),
      ],
    );
  }

  // StudyInitState, StudyReadyState
  // 학습 시작하기
  Widget btnSetOnReady(BuildContext context, StudyState state) {
    StudyBloc studyBloc = StudyBloc.read(context);
    return Row(
      children: [
        controlBtn(
          onPressed: () {
            studyBloc.add(StudyStartEvent());
          },
          child: const Text("시작하기"),
          style: BtnStyles(context).onPrimary,
        ),
      ],
    );
  }

  // StudyStartState,
  // StudyPauseState,
  Widget btnSetOnStart(BuildContext context, StudyState state) {
    StudyBloc studyBloc = StudyBloc.read(context);
    return Row(
      children: [
        if(state is StudyStartState)
          controlBtn(
            onPressed: () {
              studyBloc.add(StudyPauseEvent());
            },
            child: const Icon(Icons.pause_rounded),
            style: BtnStyles(context).onPrimary,
          ),
        if(state is StudyPauseState)
          controlBtn(
            onPressed: () {
              studyBloc.add(StudyRestartEvent());
            },
            child: const Icon(Icons.play_arrow_rounded),
            style: BtnStyles(context).onPrimary,
          ),
        controlBtn(
          onPressed: () {
            studyBloc.add(StudyStopEvent());
          },
          child: const Icon(Icons.stop_rounded),
          style: BtnStyles(context).onPrimary,
        ),
      ],
    );
  }
  // StudyCompleteState
  Widget btnSetOnCompleted(BuildContext context, StudyState state) {
    StudyBloc studyBloc = StudyBloc.read(context);
    return Row(
      children: [
        controlBtn(
          onPressed: () {
            studyBloc.add(StudyStartEvent());
          },
          child: const Text("다시하기"),
          style: BtnStyles(context).onPrimary,
        ),
        controlBtn(
          onPressed: () {
            studyBloc.add(StudyUploadEvent());
          },
          child: const Text("업로드"),
          style: BtnStyles(context).onPrimary,
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) =>
      StudyBloc.consumer(builder: (BuildContext context, StudyState state) {

        return layout(context,
            child: Row(
              children: [
                btnStudyModeSelector(context, state),
                const Spacer(),
                if(state is StudyInitState)
                  btnSetOnReady(context, state),
                if(state is StudyStartState || state is StudyPauseState )
                  btnSetOnStart(context, state),
                if(state is StudyCompleteState)
                  btnSetOnCompleted(context, state),
              ],
            ));
      });
}
