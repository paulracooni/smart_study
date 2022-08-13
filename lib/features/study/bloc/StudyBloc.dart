import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final int minSpeed = 1;
  final int maxSpeed = 4;

  final StudyInfo studyInfo;

  final Ticker _ticker = const Ticker();

  // For paragraph view
  double cWidth = 0.0;
  double itemHeight = 28.0;
  double itemsCount = 20; // Initialized at Initializer
  double screenWidth = 1024; // Initialized at ParagraphView.build
  final paragraphController = ScrollController();

  StreamSubscription<int>? _tickerSubscription;

  StudyBloc({required this.studyInfo})
      : super(const StudyInitState(
          seqRandMode: SeqRandomMode.random,
          speed: 1,
          tickPeriod: 0,
        )) {
    on<TickedEvent>(_ticked);

    on<StudyStartEvent>(_startStudy);
    on<StudyPauseEvent>(_pauseStudy);
    on<StudyRestartEvent>(_restartStudy);
    on<StudyStopEvent>(_stopStudy);
    on<StudyCompleteEvent>(_completeStudy);

    on<ClickSeqRandBtnEvent>(_toggleSeqRandomMode);
    on<ClickSpeedBtnEvent>(_toggleSpeed);

    on<StudyUploadEvent>((event, emit) {});

    itemsCount = studyInfo.paragraphs.length as double;
  }

  // static BlocProvider<StudyBloc> get provider =>
  //     BlocProvider<StudyBloc>(create: (context) => StudyBloc());

  static Widget consumer({required BlocWidgetBuilder<StudyState> builder}) =>
      BlocBuilder<StudyBloc, StudyState>(builder: builder);


  static StudyBloc read(BuildContext context) =>
      BlocProvider.of<StudyBloc>(context, listen: true);



  void _startStudy(StudyStartEvent event, Emitter<StudyState> emit) {
    emit(StudyStartState(
      seqRandMode: state.seqRandMode,
      speed: state.speed,
      tickPeriod: 0,
    ));

    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick()
        .listen((tickPeriod) => add(TickedEvent(tickPeriod: tickPeriod)));
  }

  void _pauseStudy(StudyPauseEvent event, Emitter<StudyState> emit) {
    if (state is StudyStartState) {
      _tickerSubscription?.pause();
      emit(StudyPauseState(
        seqRandMode: state.seqRandMode,
        speed: state.speed,
        tickPeriod: state.tickPeriod,
      ));
    }
  }

  void _restartStudy(StudyRestartEvent event, Emitter<StudyState> emit) {
    if (state is StudyPauseState) {
      _tickerSubscription?.resume();
      emit(StudyStartState(
        seqRandMode: state.seqRandMode,
        speed: state.speed,
        tickPeriod: state.tickPeriod,
      ));
    }
  }

  void _stopStudy(StudyStopEvent event, Emitter<StudyState> emit) {
    if (state is StudyStartState || state is StudyPauseState) {
      _tickerSubscription?.cancel();
      emit(StudyInitState(
        seqRandMode: state.seqRandMode,
        speed: state.speed,
        tickPeriod: 0,
      ));
    }
  }

  void _completeStudy(StudyCompleteEvent event, Emitter<StudyState> emit) {
    if (state is StudyStartState) {
      _tickerSubscription?.cancel();
      emit(StudyCompleteState(
        seqRandMode: state.seqRandMode,
        speed: state.speed,
        tickPeriod: state.tickPeriod,
      ));
    }
  }

  void _toggleSeqRandomMode(
      ClickSeqRandBtnEvent event, Emitter<StudyState> emit) {
    emit(state.copyWith(
      state.seqRandMode == SeqRandomMode.sequential
          ? SeqRandomMode.random
          : SeqRandomMode.sequential,
      state.speed,
      state.tickPeriod,
    ));
  }

  void _toggleSpeed(ClickSpeedBtnEvent event, Emitter<StudyState> emit) {
    emit(state.copyWith(
      state.seqRandMode,
      state.speed >= maxSpeed ? minSpeed : state.speed + 1,
      state.tickPeriod,
    ));
  }

  void _ticked(TickedEvent event, Emitter<StudyState> emit) {
    // cWidth = paragraphController.offset * screenWidth / (itemHeight * itemsCount);

    paragraphController.animateTo(
        itemHeight * event.tickPeriod * 2,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutExpo
    );

    emit(state.copyWith(
      state.seqRandMode,
      state.speed,
      event.tickPeriod,
    ));
  }

}
