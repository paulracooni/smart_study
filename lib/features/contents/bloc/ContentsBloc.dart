import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsEvent.dart';
import 'package:smart_care/features/contents/bloc/ContentsState.dart';
import 'package:smart_care/features/contents/domains/PickedInfo.dart';
import 'dart:math';

class ContentsBloc extends Bloc<ContentsEvent, ContentsState> {
  final pickedInfo = PickedInfo(authToken: "?????");
  final sentencesSelector = DragSelectGridViewController();


  ContentsBloc() : super(ContentsInitState()) {

    on<InitializedEvent>(_emitIndexUpdatedState);
    on<SentenceSelectEvent>(_emitIndexUpdatedState);
    on<UpdateIndexEvent>(_updateIndexHandler);

    on<SelectSentencesRandomlyEvent>(_randomlySentencesSelectHandler);
    on<SelectAllSentencesEvent>(_selectAllSentencesHandler);
    on<DeselectAllSentencesEvent>(_deselectAllSentencesHandler);

    _initSentenceSelector();
    sentencesSelector.addListener(() {
      add(SentenceSelectEvent(Random().nextInt(9999)));
    });
  }

  static Widget consumer({required BlocWidgetBuilder<ContentsState> builder}) =>
      BlocBuilder<ContentsBloc, ContentsState>(builder: builder);

  static ContentsBloc read(BuildContext context) =>
      BlocProvider.of<ContentsBloc>(context, listen: true);

  void _updateIndexHandler(
      UpdateIndexEvent event, Emitter<ContentsState> emit) {
    pickedInfo.updateIndexByHeaderName(event.headerName, event.index);
    _initSentenceSelector();
    emit(IndexUpdatedState());
  }

  void _emitIndexUpdatedState(
      ContentsEvent event, Emitter<ContentsState> emit) {
    emit(IndexUpdatedState());
  }

  void _initSentenceSelector() {
    sentencesSelector.clear();
    sentencesSelector.value = Selection(const <int>{0, 1, 2, 3, 4, 5, 6, 7});
  }

  int get nSelectedSentences {
    return sentencesSelector.value.selectedIndexes.length;
  }

  bool get isAllSentencesSelected {
    int nSelected = sentencesSelector.value.selectedIndexes.length;
    int nSentences = pickedInfo.sentences.length;
    return nSelected == nSentences;
  }

  void _randomlySentencesSelectHandler(
      ContentsEvent event, Emitter<ContentsState> emit) {
    int nSelection = min(8, pickedInfo.sentences.length);
    List<int> indices =
        pickedInfo.sentences.asMap().entries.map((e) => e.key).toList();
    indices.shuffle();
    Set<int> selectedIndices = indices.take(nSelection).toSet();

    sentencesSelector.clear();
    sentencesSelector.value = Selection(selectedIndices);
    emit(IndexUpdatedState());
  }

  void _selectAllSentencesHandler(
      ContentsEvent event, Emitter<ContentsState> emit) {
    Set<int> selectedIndices =
        pickedInfo.sentences.asMap().entries.map((e) => e.key).toSet();

    sentencesSelector.clear();
    sentencesSelector.value = Selection(selectedIndices);

    emit(IndexUpdatedState());
  }

  void _deselectAllSentencesHandler(
      ContentsEvent event, Emitter<ContentsState> emit) {
    sentencesSelector.clear();
    emit(IndexUpdatedState());
  }

  List<String> get selectedSentences {
    Set<int> selectedIndexes = sentencesSelector.value.selectedIndexes;
    return pickedInfo.sentences
        .asMap()
        .entries
        .where((e) => selectedIndexes.contains(e.key))
        .map((e) => e.value)
        .toList();
  }
}
