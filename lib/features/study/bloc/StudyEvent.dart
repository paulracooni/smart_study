import 'package:camera/camera.dart';

abstract class StudyEvent {}

class StudyReadyEvent extends StudyEvent {}

class StudyStartEvent extends StudyEvent {}

class StudyPauseEvent extends StudyEvent {}

class StudyStopEvent extends StudyEvent {}

class StudyCompleteEvent extends StudyEvent {}
