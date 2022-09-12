import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';
import 'package:smart_care/features/navigation/bloc/NavBloc.dart';
import 'package:smart_care/features/navigation/bloc/NavState.dart';
import 'package:smart_care/features/navigation/animated_nav_left.dart';
import 'package:smart_care/features/navigation/animated_nav_bottom.dart';

import 'contents/ContentsView.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  Widget navPage(int navIndex) {
    switch (navIndex) {
      case 0:
        return BlocProvider(
          create: (BuildContext context) =>
              ContentsBloc(),
          child: const ContentsView(viewMode: ViewMode.practice),
        );
      case 1:
        return BlocProvider(
          create: (BuildContext context) =>
              ContentsBloc(),
          child: const ContentsView(viewMode: ViewMode.test),
        );
      case 2:
        return const Center(child: Text('My Page'));
      default:
        return const Center(child: Text('Study'));
    }
  }

  @override
  Widget build(BuildContext context) {
    NavBloc bloc = NavBloc.read(context);
    return NavBloc.consumer(builder: (BuildContext context, NavState state) {
      return Stack(
        children: [
          Row(
            children: [
              const AnimatedNavLeft(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: navPage(bloc.navModel.navIndex)),
                    const AnimatedNavBottom(),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
