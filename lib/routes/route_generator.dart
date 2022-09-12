import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/constants/content_datas.dart';

import 'package:smart_care/features/onboard.dart';
import 'package:smart_care/features/navigation/bloc/NavBloc.dart';
import 'package:smart_care/features/study/StudyView.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/models/StudyInfo.dart';

import 'route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.ONBOARD:
        return _GeneratePageRoute(
          widget: BlocProvider(
              create: (BuildContext context) => NavBloc(),
              child: const OnBoard()),
          routeName: settings.name!,
        );
      case RouteName.STUDY:
        return _GeneratePageRoute(
          widget: BlocProvider(
            create: (BuildContext context) => StudyBloc(
              studyInfo: settings.arguments != null
                  ? settings.arguments! as StudyInfo
                  : StudyInfo(
                      paragraphs: contentSentences,
                      studyTitle: "Debugging",
                    ),
            ),
            child: const StudyView(),
          ),
          routeName: settings.name!,
        );

      default:
        return _GeneratePageRoute(
          widget: undefinedPage(settings.name!),
          routeName: settings.name!,
        );
    }
  }

  static Widget undefinedPage(String name) {
    return Scaffold(
      body: Center(
        child: Text(name),
      ),
    );
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;

  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
