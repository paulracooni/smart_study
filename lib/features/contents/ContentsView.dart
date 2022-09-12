import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsEvent.dart';

import 'bloc/ContentsState.dart';
import 'widgets/ContentsPicker.dart';
import 'widgets/ContentsPreview.dart';

enum ViewMode {
  practice, test
}

class ContentsView extends StatefulWidget {
  final ViewMode viewMode;
  const ContentsView({Key? key, required this.viewMode}) : super(key: key);


  @override
  State<ContentsView> createState() => _ContentsViewState();
}

class _ContentsViewState extends State<ContentsView> {
  DisplayMode get displayMode {
    return MediaQuery.of(context).displayMode;
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = DisplayMode.DESKTOP == MediaQuery.of(context).displayMode;

    return ContentsBloc.consumer(
      builder: (BuildContext context, ContentsState state) {
        ContentsBloc contentsBloc = ContentsBloc.read(context);
        if(state is ContentsInitState) {
          contentsBloc.pickedInfo.initialize().then((value) {
            contentsBloc.add(InitializedEvent());
          });
          return const Center(child: CircularProgressIndicator());
        }

        return Flex(
          direction: displayMode == DisplayMode.DESKTOP
              ? Axis.horizontal
              : Axis.vertical,
          // direction: Axis.horizontal,
          children: [
            Expanded(
              flex: isDesktop?3:2,
              child: const ContentsPicker(),
            ),
            Expanded(
              flex: 5,
              child: ContentsPreview(viewMode: widget.viewMode,),
            ),
          ],
        );
      },
    );
  }
}
