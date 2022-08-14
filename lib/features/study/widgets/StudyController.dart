import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_care/constants/design/btn_styles.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/bloc/StudyEvent.dart';
import 'package:smart_care/features/study/bloc/StudyState.dart';
import 'package:universal_html/html.dart';

class StudyController extends StatelessWidget {
  const StudyController({Key? key}) : super(key: key);

  Widget layout(BuildContext context, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      color: Theme.of(context).colorScheme.primary,
      child: child,
    );
  }

  Widget controlBtn({
    required void Function() onPressed,
    required ButtonStyle style,
    required Widget child,
  }) {
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
        if (state is! StudyPauseState)
          controlBtn(
            onPressed: () {
              studyBloc.add(ClickSeqRandBtnEvent());
            },
            style: BtnStyles(context).onPrimary,
            child: Text(state.seqRandMode),
          ),
        controlBtn(
          onPressed: () {
            studyBloc.add(ClickSpeedBtnEvent());
          },
          style: BtnStyles(context).onPrimary,
          child: Text("Speed ${state.speed} 초"),
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
  Widget btnSetParagraphControl(BuildContext context, StudyState state) {
    StudyBloc studyBloc = StudyBloc.read(context);
    return Row(
      children: [
        controlBtn(
          onPressed: () {
            studyBloc.add(PreviousParagraphEvent());
          },
          child: const Icon(Icons.keyboard_double_arrow_left_rounded),
          style: BtnStyles(context).onPrimary,
        ),
        controlBtn(
          onPressed: () {
            studyBloc.add(NextParagraphEvent());
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded),
          style: BtnStyles(context).onPrimary,
        ),
      ],
    );
  }

  Widget btnSetOnStart(BuildContext context, StudyState state) {
    StudyBloc studyBloc = StudyBloc.read(context);

    return Row(
      children: [
        if (state is StudyStartState)
          controlBtn(
            onPressed: () {
              studyBloc.add(StudyPauseEvent());
            },
            child: const Icon(Icons.pause_rounded),
            style: BtnStyles(context).onPrimary,
          ),
        if (state is StudyPauseState)
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
          child: const Text("다운로드"),
          style: BtnStyles(context).onPrimary,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => StudyBloc.consumer(
        builder: (BuildContext context, StudyState state) {
          StudyBloc studyBloc = StudyBloc.read(context);
          late Widget buttonSetWidget;
          if (state is StudyStartState) {
            buttonSetWidget = Row(
              children: [
                btnSetParagraphControl(context, state),
                const Spacer(),
                btnSetOnStart(context, state)
              ],
            );
          } else if (state is StudyPauseState) {
            buttonSetWidget = Row(
              children: [
                btnStudyModeSelector(context, state),
                const Spacer(),
                btnSetOnStart(context, state)
              ],
            );
          } else if (state is StudyCompleteState) {
            buttonSetWidget = Row(
              children: [
                btnStudyModeSelector(context, state),
                const Spacer(),
                btnSetOnCompleted(context, state)
              ],
            );
          } else {
            buttonSetWidget = Row(
              children: [
                btnStudyModeSelector(context, state),
                const Spacer(),
                btnSetOnReady(context, state)
              ],
            );
          }

          return RawKeyboardListener(
            autofocus: true,
            focusNode: FocusNode(),
            child: layout(context, child: buttonSetWidget),
            onKey: (event) {
              if (event is RawKeyDownEvent) {
                // ON Every State
                if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                  return;
                }
                // ON StudyInitState
                if (state is StudyInitState) {
                  if (event.isKeyPressed(LogicalKeyboardKey.space) ||
                      event.isKeyPressed(LogicalKeyboardKey.enter)) {
                    studyBloc.add(StudyStartEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
                    studyBloc.add(ClickSeqRandBtnEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.keyX)) {
                    studyBloc.add(ClickSpeedBtnEvent());
                  }
                  // ON StudyStartState
                } else if (state is StudyStartState) {
                  if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                    studyBloc.add(StudyPauseEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
                      event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
                    studyBloc.add(PreviousParagraphEvent());
                  } else if (event
                          .isKeyPressed(LogicalKeyboardKey.arrowRight) ||
                      event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                    studyBloc.add(NextParagraphEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.escape) ||
                      event.isKeyPressed(LogicalKeyboardKey.backspace)) {
                    studyBloc.add(StudyStopEvent());
                  }
                  // ON StudyPauseState
                } else if (state is StudyPauseState) {
                  if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                    studyBloc.add(StudyRestartEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
                    studyBloc.add(StudyStopEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.keyX)) {
                    studyBloc.add(ClickSpeedBtnEvent());
                  }
                  // ON StudyCompleteEvent
                } else if (state is StudyCompleteState) {
                  if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                    studyBloc.add(StudyStartEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
                      event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                    studyBloc.add(StudyUploadEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.keyZ)) {
                    studyBloc.add(ClickSeqRandBtnEvent());
                  } else if (event.isKeyPressed(LogicalKeyboardKey.keyX)) {
                    studyBloc.add(ClickSpeedBtnEvent());
                  }
                }
              }
            },
          );
        },
      );
}
