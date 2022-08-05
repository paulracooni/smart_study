// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

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