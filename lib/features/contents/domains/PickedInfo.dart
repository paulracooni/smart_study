// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_care/constants/content_datas.dart';

class ContentsSelectionHeader {
  static const String level = 'Level';
  static const String book = 'Book';
  static const String chapter = 'Chapter';
}

class PickedInfo extends Equatable {
  /// Server로 부터 Contents를 불러오고 선택하면 갱신하고 이것저것 한다.
  /// User의 마지막 진행 상황을 API로 부터 전달 받음
  /// Level 선택 시 Books Update;
  /// Books 선택 시, Chapter Update
  /// Chapter Update 시 Contents Update

  PickedInfo({required authToken}) : _authToken = authToken {}

  Future<void> initialize() async {

    //@TODO:  _authToken을 레퍼런스로 초기 상태 값을 불러온다.
    // _levels;  //@TODO API에서 contentLevels 불러오기
    // _books; //@TODO API에서 contentBook 불러오기
    // _chapters; //@TODO API에서 contentChapter 불러오기
    // _sentences; //@TODO API에서 contentSentences 불러오기
    // _indexLevel; //@TODO API에서 _indexLevel 불러오기
    // _indexBook; //@TODO API에서 _indexBook 불러오기
    // _indexChapter; //@TODO API에서 _indexChapter 불러오기

    final String response =
        await rootBundle.loadString('assets/dummy_datas.json');
    _datas = await json.decode(response);
    _indexLevel = 0;
    _indexBook = 0;
    _indexChapter = 0;

    _levels = List<String>.from(_datas.keys.toList());
    String levelKey = _levels[_indexLevel];

    _books = List<String>.from(_datas[levelKey].keys.toList());
    String bookKey = _books[_indexBook];

    _chapters = List<String>.from(_datas[levelKey][bookKey].keys.toList());
    String chapterKey = _chapters[_indexChapter];

    _sentences = List<String>.from(_datas[levelKey][bookKey][chapterKey]);

  }

  // @TODO API 정의 시, UserID로 컨텐츠 갱신
  final String _authToken;

  late dynamic _datas;
  late List<String> _levels;
  late List<String> _books;
  late List<String> _chapters;
  late List<String> _sentences;

  int _indexLevel = 0;
  int _indexBook = 0;
  int _indexChapter = 0;

  List<String> get levels => _levels;

  List<String> get books => _books;

  List<String> get chapters => _chapters;

  List<String> get sentences => _sentences;

  int get indexLevel => _indexLevel;

  int get indexBook => _indexBook;

  int get indexChapter => _indexChapter;

  // indexLevel 선택 시, books update
  set indexLevel(int value) {
    assert(value < levels.length);
    _indexLevel = value;
    _updateBooksBy(indexLevel);
  }

  // indexBook 선택 시, Chapter update
  set indexBook(int value) {
    assert(value < books.length);
    _indexBook = value;
    _updateChaptersBy(indexLevel, indexBook);
  }

  // indexChapter 선택 시, Sentence update
  set indexChapter(int indexChapter) {
    assert(indexChapter < chapters.length);
    _indexChapter = indexChapter;
    _updateSentencesBy(indexLevel, indexBook, indexChapter);
  }

  Future<void> _updateBooksBy(int indexLevel) async {
    _indexLevel = indexLevel;
    String levelKey = _levels[_indexLevel];
    //@TODO API에서 contentsBook 불러오기
    _books = List<String>.from(_datas[levelKey].keys.toList());
    indexBook = 0;
  }

  Future<void> _updateChaptersBy(int indexLevel, int indexBook) async {
    _indexLevel = indexLevel;
    _indexBook = indexBook;

    String levelKey = _levels[_indexLevel];
    _books = List<String>.from(_datas[levelKey].keys.toList());
    String bookKey = _books[_indexBook];

    //@TODO API에서 contentChapter 불러오기
    _chapters =  List<String>.from(_datas[levelKey][bookKey].keys.toList());
    indexChapter = 0;
  }

  Future<void> _updateSentencesBy(
      int indexLevel, int indexBook, int indexChapter) async {
    _indexLevel = indexLevel;
    _indexBook = indexBook;
    _indexChapter = indexChapter;

    _levels = List<String>.from(_datas.keys.toList());
    String levelKey = _levels[_indexLevel];

    _books = List<String>.from(_datas[levelKey].keys.toList());
    String bookKey = _books[_indexBook];

    _chapters = List<String>.from(_datas[levelKey][bookKey].keys.toList());
    String chapterKey = _chapters[_indexChapter];

    _sentences = List<String>.from(_datas[levelKey][bookKey][chapterKey]); //@TODO API에서 contentSentences 불러오기
  }

  List<String> getListByHeaderName(String headerName) {
    switch (headerName) {
      case ContentsSelectionHeader.level:
        return levels;
      case ContentsSelectionHeader.book:
        return books;
      case ContentsSelectionHeader.chapter:
        return chapters;
      default:
        return [];
    }
  }

  int getIndexByHeaderName(String headerName) {
    switch (headerName) {
      case ContentsSelectionHeader.level:
        return indexLevel;
      case ContentsSelectionHeader.book:
        return indexBook;
      case ContentsSelectionHeader.chapter:
        return indexChapter;
      default:
        return 0;
    }
  }

  void updateIndexByHeaderName(String headerName, int index) {
    switch (headerName) {
      case ContentsSelectionHeader.level:
        indexLevel = index;
        break;
      case ContentsSelectionHeader.book:
        indexBook = index;
        break;
      case ContentsSelectionHeader.chapter:
        indexChapter = index;
        break;
    }
  }

  String getCurrentPick() {
    return "${levels[indexLevel]}/"
        "${books[indexBook]}/"
        "${chapters[indexChapter]}";
  }

  @override
  List<Object?> get props => [
        _levels,
        _books,
        _chapters,
        _sentences,
        _indexLevel,
        _indexBook,
        _indexChapter
      ];
}
