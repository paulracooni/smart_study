import 'package:flutter/material.dart';
import 'package:smart_care/constants/content_datas.dart';
import 'package:smart_care/constants/design/effects.dart';


// ignore: must_be_immutable
class SentenceSlider extends StatefulWidget {
  List<String> sentences;

  SentenceSlider({
    Key? key,
    required this.sentences,
  }) : super(key: key);

  @override
  State<SentenceSlider> createState() => _SentenceSliderState();
}

class _SentenceSliderState extends State<SentenceSlider> {
  @override
  Widget build(BuildContext context) {
    // @TODO: 스크롤이 Listener에 의해 위치가 바뀌게 하는 방법?
    // flag를 하나두세요.
    // flag에 따라서, a version, b version.
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: contentSentences
              .asMap()
              .entries
              .map((entry) {
            int idx = entry.key;
            String sentence = entry.value;
            return Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primaryContainer,
                boxShadow: Effects.boxShadowEffect(context),
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(sentence),
            );
          }).toList()),
    );
  }
}


