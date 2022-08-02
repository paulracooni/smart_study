import 'package:flutter/material.dart';
import 'package:smart_care/constants/content_datas.dart';
import 'package:smart_care/features/contents_old/content_selector.dart';
import 'package:smart_care/features/study_old/study_view.dart';

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
        Expanded(
          child: ContentSelector(
            name: "Level",
            items: contentLevels,
            controller: levelController,
          ),
        ),
        Expanded(
          child: ContentSelector(
            name: "Book",
            items: contentBook,
            controller: bookController,
          ),
        ),
        Expanded(
          child: ContentSelector(
              name: "Chapter",
              items: contentChapter,
              controller: chapterController),
        ),
        // Contents Preview
        Expanded(
          flex: 3,
          child: ContentPreview(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const StudyView())
              );
            },
            headerTitle:
                "${contentLevels[levelController.value]} /"
                "${contentBook[bookController.value]} /"
                "${contentChapter[chapterController.value]}",
            sentences: sentences,
          ),
        )
      ],
    );
  }
}
