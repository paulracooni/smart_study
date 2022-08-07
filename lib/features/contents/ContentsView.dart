import 'package:flutter/material.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';

import 'bloc/ContentsState.dart';
import 'widgets/ContentsPicker.dart';
import 'widgets/ContentsPreview.dart';

class ContentsView extends StatefulWidget {
  const ContentsView({Key? key}) : super(key: key);

  @override
  State<ContentsView> createState() => _ContentsViewState();
}

class _ContentsViewState extends State<ContentsView> {
  DisplayMode get displayMode {
    return MediaQuery.of(context).displayMode;
  }

  @override
  Widget build(BuildContext context) {
    return ContentsBloc.consumer(
        builder: (BuildContext context, ContentsState state) {
      return Flex(
        direction: displayMode==DisplayMode.DESKTOP
          ?Axis.horizontal
          :Axis.vertical,
        children: const [
          ContentsPicker(),
          Expanded(child: ContentsPreview(),),
        ],
      );
    });
  }
}
