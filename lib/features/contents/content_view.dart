import 'package:flutter/material.dart';
import 'package:smart_care/constants/content_datas.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/features/contents/content_selector.dart';

import 'content_preview.dart';

class ContentSelectController {
  int index;

  ContentSelectController({
    required this.index,
  });
}

class ContentView extends StatefulWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  ValueNotifier<int> levelController = ValueNotifier<int>(0);
  ValueNotifier<int> bookController = ValueNotifier<int>(0);
  ValueNotifier<int> chapterController = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    if (mounted) {
      // set controller SideMenuItem page controller callback
      levelController.addListener(() {
        setState(() {});
      });
      bookController.addListener(() {
        setState(() {});
      });
      chapterController.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contents Selector
        ContentSelector(
          name: "Level",
          items: contentLevels,
          controller: levelController,
        ),
        ContentSelector(
          name: "Book",
          items: contentBook,
          controller: bookController,
        ),
        ContentSelector(
            name: "Chapter",
            items: contentChapter,
            controller: chapterController),

        // Contents Preview
        Expanded(
          child: ContentPreview(
            headerTitle:
                "${contentLevels[levelController.value]} /"
                "${contentBook[bookController.value]} /"
                "${contentChapter[chapterController.value]}",
            sentences: const [
              "안녕",
              "너는보니?",
              "반갑다",
            ],
          ),
        )
      ],
    );
  }
}
