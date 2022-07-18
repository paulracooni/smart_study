import 'package:flutter/material.dart';
import 'package:smart_care/constants/content_datas.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/features/contents/presentation/content_selector.dart';

class ContentView extends StatefulWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        // Contents Selector
        ContentSelector(
          name: "Level",
          items: contentLevels,
        ),
        ContentSelector(
          name: "Book",
          items: contentBook,
        ),
        ContentSelector(
          name: "Chapter",
          items: contentChapter,
        ),
        // Contents Preview
      ],
    );
  }
}
