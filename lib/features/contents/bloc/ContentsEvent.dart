// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class ContentsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateIndexEvent extends ContentsEvent {
  String headerName;
  int index;
  UpdateIndexEvent(this.headerName, this.index);

  @override
  List<Object> get props => [index, headerName];
}

class SelectPickEvent extends ContentsEvent {
  String headerName;
  String itemName;
  SelectPickEvent(this.headerName, this.itemName);

  @override
  List<Object> get props => [headerName, itemName];
}

class InitializedEvent extends ContentsEvent {}


class SentenceSelectEvent extends ContentsEvent {
  int key;
  SentenceSelectEvent(this.key);

  @override
  List<Object> get props => [key];
}

class SelectSentencesRandomlyEvent extends ContentsEvent {
  int key;
  SelectSentencesRandomlyEvent(this.key);

  @override
  List<Object> get props => [key];
}

class SelectAllSentencesEvent extends ContentsEvent {
  int key;
  SelectAllSentencesEvent(this.key);

  @override
  List<Object> get props => [key];
}

class DeselectAllSentencesEvent extends ContentsEvent {
  int key;
  DeselectAllSentencesEvent(this.key);

  @override
  List<Object> get props => [key];
}