import 'package:flutter/material.dart';
import 'package:smart_care/constants/content_datas.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';
import 'package:smart_care/features/contents/domains/ContentsSelectionAPI.dart';
import 'package:smart_care/features/contents/widgets/ContentsSlider.dart';

class ContentsPicker extends StatelessWidget {
  const ContentsPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    ContentsBloc contentsBloc = ContentsBloc.read(context);

    return Flex(
      direction:
          displayMode == DisplayMode.DESKTOP ? Axis.horizontal : Axis.vertical,
      children: [
        ContentsSlider(
          headerName: ContentsSelectionHeader.level,
          itemNames: contentsBloc.contentsSelection.levels,
        ),
        ContentsSlider(
          headerName: ContentsSelectionHeader.book,
          itemNames: contentsBloc.contentsSelection.books,
        ),
        ContentsSlider(
          headerName: ContentsSelectionHeader.chapter,
          itemNames: contentsBloc.contentsSelection.chapters,
        ),
      ],
    );
  }
}
