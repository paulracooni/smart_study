import 'package:flutter/material.dart';
import 'package:smart_care/features/study/bloc/StudyEvent.dart';

import 'StudyState.dart';

class ParagraphUtil {
  double cWidth = 0.0;
  double itemHeight = 60;
  int itemsCount = 20; // Initialized at Initializer at StudyBloc

  final controller = ScrollController();

  ParagraphUtil();

  void resetScroll() {

    controller.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutExpo
    );
  }

  void moveScroll(int paragraphIndex) {
    if (0 <= paragraphIndex || paragraphIndex < itemsCount) {
      controller.animateTo(
        itemHeight * paragraphIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutExpo,
      );
    }
  }

}