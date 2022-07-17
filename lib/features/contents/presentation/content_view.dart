import 'package:flutter/material.dart';
import 'package:smart_care/constants/content_datas.dart';
import 'package:smart_care/features/contents/presentation/content_selector.dart';

class ContentView extends StatelessWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contents Selector
        ContentSelector(name:"Level", items: contentLevels),
        ContentSelector(name:"Book", items: contentBook),
        ContentSelector(name:"Chapter", items: contentChapter)
        // Contents Preview
      ],
    );
  }
}
