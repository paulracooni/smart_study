import 'package:equatable/equatable.dart';

class StudyState extends Equatable {
  final String seqRandMode;
  final int speed;
  final int tickPeriod;

  const StudyState(
      {required this.seqRandMode,
      required this.speed,
      required this.tickPeriod});

  StudyState copyWith(String seqRandMode, int speed, int tickPeriod) =>
      StudyState(
          seqRandMode: seqRandMode, speed: speed, tickPeriod: tickPeriod);

  @override
  List<Object?> get props => [seqRandMode, speed, tickPeriod];
}

class StudyInitState extends StudyState {
  const StudyInitState(
      {required seqRandMode, required speed, required tickPeriod})
      : super(seqRandMode: seqRandMode, speed: speed, tickPeriod: tickPeriod);

  @override
  StudyInitState copyWith(String seqRandMode, int speed, int tickPeriod) =>
      StudyInitState(
          seqRandMode: seqRandMode, speed: speed, tickPeriod: tickPeriod);
}

class StudyStartState extends StudyState {
  const StudyStartState(
      {required seqRandMode, required speed, required tickPeriod})
      : super(seqRandMode: seqRandMode, speed: speed, tickPeriod: tickPeriod);

  @override
  StudyStartState copyWith(
    String seqRandMode,
    int speed,
    int tickPeriod,
  ) =>
      StudyStartState(
        seqRandMode: seqRandMode,
        speed: speed,
        tickPeriod: tickPeriod,
      );
}

class StudyPauseState extends StudyState {
  const StudyPauseState(
      {required seqRandMode, required speed, required tickPeriod})
      : super(seqRandMode: seqRandMode, speed: speed, tickPeriod: tickPeriod);

  @override
  StudyPauseState copyWith(
    String seqRandMode,
    int speed,
    int tickPeriod,
  ) =>
      StudyPauseState(
          seqRandMode: seqRandMode, speed: speed, tickPeriod: tickPeriod);

  @override
  List<Object?> get props => [seqRandMode, speed, tickPeriod];
}

class StudyCompleteState extends StudyState {
  const StudyCompleteState(
      {required seqRandMode, required speed, required tickPeriod})
      : super(seqRandMode: seqRandMode, speed: speed, tickPeriod: tickPeriod);

  @override
  StudyCompleteState copyWith(String seqRandMode, int speed, int tickPeriod) =>
      StudyCompleteState(
          seqRandMode: seqRandMode, speed: speed, tickPeriod: tickPeriod);

  @override
  List<Object?> get props => [seqRandMode, speed, tickPeriod];
}

// class VideoFailureState extends StudyState {
//   String? error;
//
//   VideoFailureState({required this.error});
// }
//
// class VideoRecordingFailureState extends StudyState {
//   String? error;
//
//   VideoRecordingFailureState({required this.error});
// }
