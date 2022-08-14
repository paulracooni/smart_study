import 'package:equatable/equatable.dart';

class StudyState extends Equatable {
  final String seqRandMode;
  final int speed;
  final int tickPeriod;
  final int paragraphIndex;

  const StudyState({
    required this.seqRandMode,
    required this.speed,
    required this.tickPeriod,
    required this.paragraphIndex,
  });

  StudyState copyWith(
          String seqRandMode, int speed, int tickPeriod, int paragraphIndex) =>
      StudyState(
          seqRandMode: seqRandMode,
          speed: speed,
          tickPeriod: tickPeriod,
          paragraphIndex: paragraphIndex);

  @override
  List<Object?> get props => [seqRandMode, speed, tickPeriod, paragraphIndex];
}

class StudyInitState extends StudyState {
  const StudyInitState({
    required seqRandMode,
    required speed,
    required tickPeriod,
    required paragraphIndex,
  }) : super(
          seqRandMode: seqRandMode,
          speed: speed,
          tickPeriod: tickPeriod,
          paragraphIndex: paragraphIndex,
        );

  @override
  StudyInitState copyWith(
          String seqRandMode, int speed, int tickPeriod, int paragraphIndex) =>
      StudyInitState(
        seqRandMode: seqRandMode,
        speed: speed,
        tickPeriod: tickPeriod,
        paragraphIndex: paragraphIndex,
      );
}

class StudyStartState extends StudyState {
  const StudyStartState({
    required seqRandMode,
    required speed,
    required tickPeriod,
    required paragraphIndex,
  }) : super(
          seqRandMode: seqRandMode,
          speed: speed,
          tickPeriod: tickPeriod,
          paragraphIndex: paragraphIndex,
        );

  @override
  StudyStartState copyWith(
    String seqRandMode,
    int speed,
    int tickPeriod,
    int paragraphIndex,
  ) =>
      StudyStartState(
        seqRandMode: seqRandMode,
        speed: speed,
        tickPeriod: tickPeriod,
        paragraphIndex: paragraphIndex,
      );
}

class StudyPauseState extends StudyState {
  const StudyPauseState(
      {required seqRandMode,
      required speed,
      required tickPeriod,
      required paragraphIndex})
      : super(
            seqRandMode: seqRandMode,
            speed: speed,
            tickPeriod: tickPeriod,
            paragraphIndex: paragraphIndex);

  @override
  StudyPauseState copyWith(
    String seqRandMode,
    int speed,
    int tickPeriod,
    int paragraphIndex,
  ) =>
      StudyPauseState(
        seqRandMode: seqRandMode,
        speed: speed,
        tickPeriod: tickPeriod,
        paragraphIndex: paragraphIndex,
      );

  @override
  List<Object?> get props => [seqRandMode, speed, tickPeriod, paragraphIndex];
}

class StudyCompleteState extends StudyState {
  const StudyCompleteState({
    required seqRandMode,
    required speed,
    required tickPeriod,
    required paragraphIndex,
  }) : super(
          seqRandMode: seqRandMode,
          speed: speed,
          tickPeriod: tickPeriod,
          paragraphIndex: paragraphIndex,
        );

  @override
  StudyCompleteState copyWith(
    String seqRandMode,
    int speed,
    int tickPeriod,
    int paragraphIndex,
  ) =>
      StudyCompleteState(
        seqRandMode: seqRandMode,
        speed: speed,
        tickPeriod: tickPeriod,
        paragraphIndex: paragraphIndex,
      );

  @override
  List<Object?> get props => [seqRandMode, speed, tickPeriod, paragraphIndex];
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
