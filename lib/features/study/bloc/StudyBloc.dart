import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/features/study/bloc/VideoUtils.dart';
import 'StudyEvent.dart';
import 'StudyState.dart';

List<CameraDescription> cameras = [];

class StudyBloc extends Bloc<StudyEvent, StudyState> {

  StudyBloc() : super(StudyInitState()) {
    on<StudyReadyEvent>((event, emit) {
      emit(StudyStartState());
    });

    on<StudyStartEvent>((event, emit) {
      emit(StudyStartState());
    });

    on<StudyPauseEvent>((event, emit) {
      emit(StudyPauseState());
    });

    on<StudyStopEvent>((event, emit) {
      emit(StudyInitState());
    });

    on<StudyCompleteEvent>((event, emit) {
      emit(StudyCompleteState());
    });
  }

  static BlocProvider<StudyBloc> get provider => BlocProvider<StudyBloc>(
      create: (context) => StudyBloc());

  static Widget consumer({required BlocWidgetBuilder<StudyState> builder}) =>
      BlocBuilder<StudyBloc, StudyState>(builder: builder);

  static StudyBloc read(BuildContext context) =>
      BlocProvider.of<StudyBloc>(context, listen: true);

}
