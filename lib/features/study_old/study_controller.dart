import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

typedef VoidCallback = void Function();

class StudyController {
  final minSpeed = 1;
  int maxSpeed;
  int sentencesLength;
  bool isRecording = false;
  late CameraController _cameraController;
  final ValueNotifier<int> _speedNotifier = ValueNotifier<int>(1);
  final ValueNotifier<int> _sentencesNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isRandomNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isStudyingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isPauseNotifier = ValueNotifier<bool>(false);

  StudyController({this.maxSpeed = 4, this.sentencesLength = 0});

  int get speed {
    return _speedNotifier.value;
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

  CameraController get camera {
    return _cameraController;
  }

  void addListener(VoidCallback listener) {
    // set controller SideMenuItem page controller callback
    _speedNotifier.addListener(listener);
    _sentencesNotifier.addListener(listener);
    _isRandomNotifier.addListener(listener);
    _isStudyingNotifier.addListener(listener);
    _isPauseNotifier.addListener(listener);
  }

  void toggleRandomMode() {
    _isRandomNotifier.value = !_isRandomNotifier.value;
  }

  void toggleSpeedMode() {
    if (_speedNotifier.value < maxSpeed) {
      _speedNotifier.value += 1;
    } else {
      _speedNotifier.value = minSpeed;
    }
  }

  void studyStart() {
    if (_isStudyingNotifier.value == false) {
      _isStudyingNotifier.value = true;
      _isPauseNotifier.value = false;
      startVideoRecording();
    }
  }

  void studyStop() {
    if (_isStudyingNotifier.value == true) {
      _isStudyingNotifier.value = false;
      _isPauseNotifier.value = false;
      _sentencesNotifier.value = 0;
      stopVideoRecording();
    }

  }

  void studyPause() {
    _isPauseNotifier.value = !_isPauseNotifier.value;
    if (_cameraController.value.isRecordingPaused==false){
      pauseVideoRecording();
    } else {
      resumeVideoRecording();
    }
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

  CameraController cameraInit(CameraDescription camera,
      {ResolutionPreset resolutionPreset = ResolutionPreset.high}) {
    _cameraController = CameraController(camera, ResolutionPreset.high);
    return _cameraController;
  }

  void cameraDispose() {
    _cameraController.dispose();
  }

  void startVideoRecording() async {
    if (_cameraController.value.isRecordingVideo==false) {
      await _cameraController.startVideoRecording();
    }
  }
  void stopVideoRecording() async {
    if (_cameraController.value.isRecordingVideo==true) {
      XFile videoFile = await _cameraController.stopVideoRecording();
      html.window.open(videoFile.path, "_blank");
    }


  }

  void pauseVideoRecording() async {
    if (_cameraController.value.isRecordingVideo==true) {
      await _cameraController.pauseVideoRecording();
    }
  }

  void resumeVideoRecording() async {
    if (_cameraController.value.isRecordingPaused==true) {
      await _cameraController.resumeVideoRecording();
    }
  }
}
