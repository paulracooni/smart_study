import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/btn_styles.dart';
import 'package:smart_care/features/study/study_controller.dart';

// ignore: must_be_immutable
class ControlView extends StatelessWidget {
  StudyController controller;

  ControlView({Key? key, required this.controller}) : super(key: key);

  EdgeInsets btnPadding =
      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0);

  Widget modeSelectBtns(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: controller.isRandomBtnActive
              ? BtnStyles(context).active
              : BtnStyles(context).inactive,
          onPressed: controller.isRandomBtnActive
              ? controller.toggleRandomMode
              : () {},
          child: controller.isRandom
              ? const Text("Random")
              : const Text("Sequential"),
        ),
        ElevatedButton(
          style: controller.isSpeedBtnActive
              ? BtnStyles(context).active
              : BtnStyles(context).inactive,
          onPressed:
              controller.isSpeedBtnActive ? controller.toggleSpeedMode : () {},
          child: Text("Speed x${controller.speed.toString()}"),
        )
      ].map((child) {
        // Add padding to all children of mode select buttons
        return Padding(
          padding: btnPadding,
          child: child,
        );
      }).toList(),

      ///TODO: Iterable 익명 함수는 어떻게 선언하는가? yield?
    );
  }

  Widget recordingBtnSets(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: controller.isPrevBtnActive
              ? BtnStyles(context).active
              : BtnStyles(context).inactive,
          onPressed: controller.isPrevBtnActive
              ? controller.subtractSentenceIndex
              : () {},
          child: const Icon(Icons.navigate_before_outlined),
        ),
        ElevatedButton(
          style: BtnStyles(context).active,
          onPressed: controller.studyPause,
          child: controller.isPause
              ? const Icon(Icons.play_arrow)
              : const Icon(Icons.pause),
        ),
        ElevatedButton(
          style: controller.isPause
              ? BtnStyles(context).inactive
              : BtnStyles(context).active,
          onPressed: controller.isPause ? () {} : controller.studyStop,
          child: const Icon(Icons.stop),
        ),
        ElevatedButton(
          style: controller.isNextBtnActive
              ? BtnStyles(context).active
              : BtnStyles(context).inactive,
          onPressed:
              controller.isNextBtnActive ? controller.addSentenceIndex : () {},
          child: const Icon(Icons.navigate_next_outlined),
        )
      ].map((child) {
        // Add padding to all children of mode select buttons
        return Padding(
          padding: btnPadding,
          child: child,
        );
      }).toList(),
    );
  }

  Widget unRecordingBtnSets(BuildContext context) {
    return Row(
        children: [
      ElevatedButton(
        style: BtnStyles(context).active,
        onPressed: controller.studyStart,
        child: const Icon(Icons.play_arrow),
      ),
    ].map((child) {
      // Add padding to all children of mode select buttons
      return Padding(
        padding: btnPadding,
        child: child,
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        controller.isStudying
            ? recordingBtnSets(context)
            : unRecordingBtnSets(context),
        const Spacer(),
        modeSelectBtns(context),
      ],
    );
  }
}
