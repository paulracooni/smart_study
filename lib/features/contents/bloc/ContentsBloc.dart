import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsEvent.dart';
import 'package:smart_care/features/contents/bloc/ContentsState.dart';

enum ContentHeaders {
  level, book, chapter
}

class ContentsModel {
  int? levelIndex;
  int? bookIndex;
  int? chapterIndex;
}

class ContentsBloc extends Bloc<ContentsEvent, ContentsState> {
  final value = ContentsModel();

  ContentsBloc() : super(InitContentsState()) {
    on<UpdateLevelIndexEvent>((event, emit) {
      value.levelIndex = event.levelIndex;
      emit(UpdatedLevelIndexState());
    });
    on<UpdateBookIndexEvent>((event, emit) {
      value.bookIndex = event.bookIndex;
      emit(UpdatedBookIndexState());
    });
    on<UpdateChapterIndexEvent>((event, emit) {
      value.chapterIndex = event.chapterIndex;
      emit(UpdatedChapterIndexState());
    });
  }

  static BlocProvider<ContentsBloc> get provider =>
      BlocProvider<ContentsBloc>(create: (context) => ContentsBloc());

  static Widget consumer({required BlocWidgetBuilder<ContentsState> builder}) =>
      BlocBuilder<ContentsBloc, ContentsState>(builder: builder);

  static ContentsBloc read(BuildContext context) =>
      BlocProvider.of<ContentsBloc>(context, listen: true);
}
