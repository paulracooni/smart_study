import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/features/navigation/bloc/NavEvent.dart';
import 'package:smart_care/features/navigation/bloc/NavState.dart';

class NavModel {
  int navIndex = 0;
}

class NavBloc extends Bloc<NavEvent, NavState> {
  final navModel = NavModel();

  NavBloc() : super(InitNavState()) {
    on<UpdateNavIndexEvent>((event, emit) {
      navModel.navIndex = event.navIndex;
      emit(UpdatedNavIndexState());
    });
  }

  static BlocProvider<NavBloc> get provider =>
      BlocProvider<NavBloc>(create: (context) => NavBloc());

  static Widget consumer({required BlocWidgetBuilder<NavState> builder}) =>
      BlocBuilder<NavBloc, NavState>(builder: builder);

  static NavBloc read(BuildContext context) =>
      BlocProvider.of<NavBloc>(context, listen: true);
}
