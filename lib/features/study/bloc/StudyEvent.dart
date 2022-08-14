import 'package:equatable/equatable.dart';


abstract class StudyEvent extends Equatable {
  const StudyEvent();

  @override
  List<Object> get props => [];
}

class StudyReadyEvent extends StudyEvent {}

class StudyStartEvent extends StudyEvent {}

class StudyRestartEvent extends StudyEvent {}

class StudyPauseEvent extends StudyEvent {}

class StudyStopEvent extends StudyEvent {}

class StudyUploadEvent extends StudyEvent {}

class StudyCompleteEvent extends StudyEvent {}

class ClickSeqRandBtnEvent extends StudyEvent {}

class ClickSpeedBtnEvent extends StudyEvent {}

class TickedEvent extends StudyEvent {
  final int tickPeriod;
  const TickedEvent({required this.tickPeriod});

  @override
  List<Object> get props => [tickPeriod];
}

class RemainTickedEvent extends StudyEvent {
  final int tickPeriod;
  const RemainTickedEvent({required this.tickPeriod});

  @override
  List<Object> get props => [tickPeriod];
}

class NextParagraphByTimerEvent extends StudyEvent {}

class NextParagraphEvent extends StudyEvent {}

class PreviousParagraphEvent extends StudyEvent {}