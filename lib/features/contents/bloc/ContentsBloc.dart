import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsEvent.dart';
import 'package:smart_care/features/contents/bloc/ContentsState.dart';
import 'package:smart_care/features/contents/domains/ContentsSelectionAPI.dart';

class ContentsBloc extends Bloc<ContentsEvent, ContentsState> {
  final contentsSelection = ContentsSelectionAPI(authToken: "?????");

  ContentsBloc() : super(ContentsInitState()) {
    on<UpdateIndexEvent>((event, emit) {
      contentsSelection.updateIndexByHeaderName(
          event.headerName, event.index
      );
      emit(IndexUpdatedState());
    });

  }

  static BlocProvider<ContentsBloc> get provider =>
      BlocProvider<ContentsBloc>(create: (context) => ContentsBloc());

  static Widget consumer({required BlocWidgetBuilder<ContentsState> builder}) =>
      BlocBuilder<ContentsBloc, ContentsState>(builder: builder);

  static ContentsBloc read(BuildContext context) =>
      BlocProvider.of<ContentsBloc>(context, listen: true);

}
