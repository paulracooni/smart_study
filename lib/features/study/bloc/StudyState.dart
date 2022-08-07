class StudyState {}
class StudyInitState extends StudyState {}
class StudyReadyState extends StudyState {}
class StudyStartState extends StudyState {}
class StudyPauseState extends StudyState {}
class StudyCompleteState extends StudyState {}

class VideoFailureState extends StudyState {
  String? error;
  VideoFailureState({required this.error});
}
class VideoRecordingFailureState extends StudyState {
  String? error;
  VideoRecordingFailureState({required this.error});
}