import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsEvent.dart';
import 'package:smart_care/features/contents/bloc/ContentsState.dart';
import 'package:smart_care/features/contents/domains/PickedInfo.dart';

class ContentsBloc extends Bloc<ContentsEvent, ContentsState> {
  final pickedInfo = PickedInfo(authToken: "?????");

  ContentsBloc() : super(ContentsInitState()) {
    on<UpdateIndexEvent>((event, emit) {
      pickedInfo.updateIndexByHeaderName(
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
