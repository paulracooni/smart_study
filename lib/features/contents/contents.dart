import 'package:flutter/material.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';

import 'bloc/ContentsState.dart';
import 'widgets/ContentsPicker.dart';

class Contents extends StatefulWidget {
  const Contents({Key? key}) : super(key: key);

  @override
  State<Contents> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
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
          Expanded(child: Center(child: Text("Contents Preview"))),
        ],
      );
    });
  }
}
