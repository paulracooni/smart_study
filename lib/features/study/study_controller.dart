import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

typedef VoidCallback = void Function();

class StudyController {
  final minSpeed = 1;
  int maxSpeed;
  int sentencesLength;

  StudyController({this.maxSpeed = 4, this.sentencesLength = 0});

  final ValueNotifier<int> _sppedNotifier = ValueNotifier<int>(1);
  final ValueNotifier<int> _sentencesNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isRandomNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isStudyingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isPauseNotifier = ValueNotifier<bool>(false);

  int get speed {
    return _sppedNotifier.value;
  }

  int get sentenceIndex {
    return _sentencesNotifier.value;
  }

  bool get isRandom {
    return _isRandomNotifier.value;
  }

  bool get isPause {
    return _isPauseNotifier.value;
  }

  bool get isStudying {
    return _isStudyingNotifier.value;
  }

  bool get isSpeedBtnActive {
    return !isStudying | isPause;
  }

  bool get isRandomBtnActive {
    return !isStudying;
  }

  bool get isPrevBtnActive {
    return (sentenceIndex != 0) & !isPause;
  }

  bool get isNextBtnActive {
    return (sentenceIndex != sentencesLength) & !isPause;
  }

  void addListener(VoidCallback listener) {
    // set controller SideMenuItem page controller callback
    _sppedNotifier.addListener(listener);
    _sentencesNotifier.addListener(listener);
    _isRandomNotifier.addListener(listener);
    _isStudyingNotifier.addListener(listener);
    _isPauseNotifier.addListener(listener);
  }

  void toggleRandomMode() {
    _isRandomNotifier.value = !_isRandomNotifier.value;
  }

  void toggleSpeedMode() {
    if (_sppedNotifier.value < maxSpeed) {
      _sppedNotifier.value += 1;
    } else {
      _sppedNotifier.value = minSpeed;
    }
  }

  void studyStart() {
    if (_isStudyingNotifier.value == false) {
      _isStudyingNotifier.value = true;
      _isPauseNotifier.value = false;
    }
  }

  void studyStop() {
    if (_isStudyingNotifier.value == true) {
      _isStudyingNotifier.value = false;
      _isPauseNotifier.value = false;
      _sentencesNotifier.value = 0;
    }
  }

  void studyPause() {
    _isPauseNotifier.value = !_isPauseNotifier.value;
  }

  void addSentenceIndex() {
    if (_sentencesNotifier.value < sentencesLength) {
      _sentencesNotifier.value += 1;
    } else {
      _sentencesNotifier.value = sentencesLength;
    }
  }

  void subtractSentenceIndex() {
    if (_sentencesNotifier.value > 0) {
      _sentencesNotifier.value -= 1;
    } else {
      _sentencesNotifier.value = 0;
    }
  }
}
