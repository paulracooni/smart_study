import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'dart:html';

// import 'dart:html';

import 'package:smart_care/features/study/bloc/ParagraphUtil.dart';
import 'package:smart_care/features/study/bloc/VideoUtils.dart';
import 'package:smart_care/features/study/models/StudyInfo.dart';
import 'StudyEvent.dart';
import 'StudyState.dart';
import 'Ticker.dart';

List<CameraDescription> cameras = [];

class SeqRandomMode {
  static const String random = "Random";
  static const String sequential = "Sequential";
}

class StudyBloc extends Bloc<StudyEvent, StudyState> {
  static int speedIndex = 1;
  static final List<int> speeds = [2, 5, 10, 15, 20, 30];

  // late int remainTime;

  final StudyInfo studyInfo;
  final ParagraphUtil paragraphUtil = ParagraphUtil();
  final Timer recordingTimer = Timer(tickTimingSec: 1);

  // late Timer remainTimer;
  late Timer nextParagraphTimer; //Initialized at Initializer StudyBloc

  StudyBloc({required this.studyInfo})
      : super(const StudyInitState(
          seqRandMode: SeqRandomMode.sequential,
          speed: 5,
          tickPeriod: 0,
          paragraphIndex: 0,
        )) {
    on<StudyStartEvent>(_startStudy);
    on<StudyPauseEvent>(_pauseStudy);
    on<StudyRestartEvent>(_restartStudy);
    on<StudyStopEvent>(_stopStudy);
    on<StudyCompleteEvent>(_completeStudy);

    on<ClickSeqRandBtnEvent>(_toggleSeqRandomMode);
    on<ClickSpeedBtnEvent>(_toggleSpeed);

    on<TickedEvent>(_ticked);
    // on<RemainTickedEvent>(_remainTicked);
    on<NextParagraphByTimerEvent>(_nextParagraphByTimer);

    on<NextParagraphEvent>(_nextParagraph);
    on<PreviousParagraphEvent>(_prevParagraph);
    on<StudyUploadEvent>(_studyUpload);

    paragraphUtil.itemsCount = studyInfo.paragraphs.length;
    nextParagraphTimer = Timer(tickTimingSec: state.speed);
    // remainTimer = Timer(tickTimingSec: 1);
    // remainTime = speeds[state.speed];
  }

  // static BlocProvider<StudyBloc> get provider =>
  //     BlocProvider<StudyBloc>(create: (context) => StudyBloc());

  static Widget consumer({required BlocWidgetBuilder<StudyState> builder}) =>
      BlocBuilder<StudyBloc, StudyState>(builder: builder);

  static StudyBloc read(BuildContext context) =>
      BlocProvider.of<StudyBloc>(context, listen: true);

  void _startStudy(StudyStartEvent event, Emitter<StudyState> emit) async {
    // remainTime = state.speed;

    VideoUtils.clear();
    await VideoUtils.startVideoRecording();

    emit(StudyStartState(
      seqRandMode: state.seqRandMode,
      speed: state.speed,
      tickPeriod: 0,
      paragraphIndex: 0,
    ));


    paragraphUtil.resetScroll();
    recordingTimer
        .start((tickPeriod) => add(TickedEvent(tickPeriod: tickPeriod)));

    _initNextParagraphTimer();
  }

  void _pauseStudy(StudyPauseEvent event, Emitter<StudyState> emit) async {
    if (state is StudyStartState) {
      await VideoUtils.pauseVideoRecording();
      recordingTimer.pause();
      // remainTimer.pause();
      nextParagraphTimer.pause();
      emit(StudyPauseState(
        seqRandMode: state.seqRandMode,
        speed: state.speed,
        tickPeriod: state.tickPeriod,
        paragraphIndex: state.paragraphIndex,
      ));
    }
  }

  void _restartStudy(StudyRestartEvent event, Emitter<StudyState> emit) async {
    if (state is StudyPauseState) {
      await VideoUtils.resumeVideoRecording();
      recordingTimer.resume();
      _initNextParagraphTimer();
      emit(StudyStartState(
        seqRandMode: state.seqRandMode,
        speed: state.speed,
        tickPeriod: state.tickPeriod,
        paragraphIndex: state.paragraphIndex,
      ));
    }
  }

  void _stopStudy(StudyStopEvent event, Emitter<StudyState> emit) async {
    // remainTime = state.speed;
    if (state is StudyStartState || state is StudyPauseState) {
      await VideoUtils.stopVideoRecording();
      // remainTimer.cancel();
      recordingTimer.cancel();
      nextParagraphTimer.cancel();
      paragraphUtil.resetScroll();
      emit(StudyInitState(
        seqRandMode: state.seqRandMode,
        speed: state.speed,
        tickPeriod: 0,
        paragraphIndex: 0,
      ));
    }
  }

  void _completeStudy(StudyCompleteEvent event, Emitter<StudyState> emit) async {
    if (state is StudyStartState) {
      await VideoUtils.stopVideoRecording();
      // remainTimer.cancel();
      recordingTimer.cancel();
      nextParagraphTimer.cancel();
      emit(StudyCompleteState(
        seqRandMode: state.seqRandMode,
        speed: state.speed,
        tickPeriod: state.tickPeriod,
        paragraphIndex: state.paragraphIndex,
      ));
    }
  }

  void _toggleSeqRandomMode(
      ClickSeqRandBtnEvent event, Emitter<StudyState> emit) {
    state.seqRandMode == SeqRandomMode.sequential
        ? studyInfo.shuffle()
        : studyInfo.rollback();

    emit(state.copyWith(
      state.seqRandMode == SeqRandomMode.sequential
          ? SeqRandomMode.random
          : SeqRandomMode.sequential,
      state.speed,
      state.tickPeriod,
      state.paragraphIndex,
    ));
  }

  void _toggleSpeed(ClickSpeedBtnEvent event, Emitter<StudyState> emit) {
    speedIndex = speeds.length > speedIndex + 1 ? speedIndex + 1 : 0;
    int nextSpeed = speeds[speedIndex];
    // remainTime = nextSpeed;
    if (state is StudyPauseState) {
      nextParagraphTimer.cancel();
      nextParagraphTimer = Timer(tickTimingSec: nextSpeed);
    } else {
      nextParagraphTimer = Timer(tickTimingSec: nextSpeed);
    }
    emit(state.copyWith(
      state.seqRandMode,
      nextSpeed,
      state.tickPeriod,
      state.paragraphIndex,
    ));
  }

  void _ticked(TickedEvent event, Emitter<StudyState> emit) {
    emit(state.copyWith(
      state.seqRandMode,
      state.speed,
      event.tickPeriod,
      state.paragraphIndex,
    ));
  }

  void _nextParagraphByTimer(
      NextParagraphByTimerEvent event, Emitter<StudyState> emit) {
    if (state.paragraphIndex + 1 < paragraphUtil.itemsCount) {
      int nextParagraphIndex =
          state.paragraphIndex + 1 < paragraphUtil.itemsCount
              ? state.paragraphIndex + 1
              : paragraphUtil.itemsCount;
      paragraphUtil.moveScroll(nextParagraphIndex);
      emit(state.copyWith(
        state.seqRandMode,
        state.speed,
        state.tickPeriod,
        nextParagraphIndex,
      ));
    } else {
      add(StudyCompleteEvent());
    }
  }

  void _nextParagraph(NextParagraphEvent event, Emitter<StudyState> emit) {
    _initNextParagraphTimer();
    if (state.paragraphIndex + 1 < paragraphUtil.itemsCount) {
      int nextParagraphIndex =
          state.paragraphIndex + 1 < paragraphUtil.itemsCount
              ? state.paragraphIndex + 1
              : paragraphUtil.itemsCount;

      paragraphUtil.moveScroll(nextParagraphIndex);
      emit(state.copyWith(
        state.seqRandMode,
        state.speed,
        state.tickPeriod,
        nextParagraphIndex,
      ));
    } else {
      add(StudyCompleteEvent());
    }
  }

  void _prevParagraph(PreviousParagraphEvent event, Emitter<StudyState> emit) {
    _initNextParagraphTimer();
    int prevParagraphIndex =
        state.paragraphIndex - 1 >= 0 ? state.paragraphIndex - 1 : 0;

    paragraphUtil.moveScroll(prevParagraphIndex);
    emit(state.copyWith(
      state.seqRandMode,
      state.speed,
      state.tickPeriod,
      prevParagraphIndex,
    ));
  }

  // void _remainTicked(RemainTickedEvent event, Emitter<StudyState> emit) {
  //   if (remainTime > 1) {
  //     remainTime--;
  //   } else {
  //     remainTime = state.speed;
  //   }
  //
  //   emit(state.copyWith(
  //     state.seqRandMode,
  //     state.speed,
  //     state.tickPeriod,
  //     state.paragraphIndex,
  //   ));
  // }

  void _initNextParagraphTimer() {
    // remainTime = state.speed;
    nextParagraphTimer.start((nextIndex) => add(NextParagraphByTimerEvent()));
    // remainTimer
    //     .start((tickPeriod) => add(RemainTickedEvent(tickPeriod: tickPeriod)));
  }

  void _studyUpload(StudyUploadEvent event, Emitter<StudyState> emit) async {
    XFile videoFile = VideoUtils.getVideoFile();
    Uint8List rawData = await videoFile.readAsBytes();
    String content = base64Encode(rawData);

    String fileName = studyInfo.studyTitle.replaceAll("/", "-");
    DateTime today = DateTime.now();
    String dateSlug =
        "${today.year.toString()}"
        "${today.month.toString().padLeft(2, '0')}"
        "${today.day.toString().padLeft(2, '0')}T"
        "${today.hour.toString().padLeft(2, '0')}"
        "${today.minute.toString().padLeft(2, '0')}"
        "${today.second.toString().padLeft(2, '0')}";

    AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "$dateSlug-$fileName.mp4")
      ..click();
  }
}
