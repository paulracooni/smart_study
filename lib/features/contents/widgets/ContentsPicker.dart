import 'package:flutter/material.dart';
import 'package:smart_care/constants/content_datas.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/widgets/ContentsSlider.dart';

class ContentsPicker extends StatelessWidget {
  const ContentsPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    return Flex(
      direction: displayMode==DisplayMode.DESKTOP
        ?Axis.horizontal
        :Axis.vertical,
      children: [
        ContentsSlider(headerName: "Level", names: contentLevels),
        ContentsSlider(headerName: "Book", names: contentBook),
        ContentsSlider(headerName: "Chapter", names: contentChapter),
      ],
    );
  }
}
