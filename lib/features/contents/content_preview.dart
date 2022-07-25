import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/effects.dart';

class ContentPreview extends StatelessWidget {
  final String headerTitle;
  final List<String> sentences;
  final void Function() onPressed;
  const ContentPreview({
    Key? key,
    required this.headerTitle,
    required this.sentences,
    required this.onPressed
  }) : super(key: key);

  Widget _header(BuildContext context) {
    const headerPadding = EdgeInsets.only(left: 20, top: 16, bottom: 10, right:20);
    TextStyle headerTextStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            );

    return Container(
      // padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: Effects.boxShadowEffect(context),
      ),
      child: Row(
        children: [
          Padding(
            padding: headerPadding,
            child: Text(
              headerTitle,
              style: headerTextStyle,
            ),
          ),
          const Spacer(),
          Padding(
            padding: headerPadding,
            child: Text(
              "# Sentences: ${sentences.length}",
              style: headerTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _preview(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: ScrollController(),
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Column(
          children: sentences.map((sentence) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: Effects.boxShadowEffect(context),
              ),
              child: Text(
                sentence,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _startBtn(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: ElevatedButton(
            onPressed: onPressed, //@TODO: 왜 Flutter는 this를 명시적으로 작성하는 것을 권장하지 않는가? ㅠㅠ 난 안쓰면 헷갈린데...
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.tertiary,
              ),
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.onTertiary,
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(20, 15, 20, 15),
              ),
            ),
            child: Text(
              "시작하기",
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          Expanded(child: _preview(context)),
          _startBtn(context),
        ],
      ),
    );
  }
}
