import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/effects.dart';

class ContentPreview extends StatelessWidget {
  final String headerTitle;
  final List<String> sentences;

  const ContentPreview({
    Key? key,
    required this.headerTitle,
    required this.sentences,
  }) : super(key: key);

  Widget _header(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: Effects.boxShadowEffect(context),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 16, bottom: 5),
            child: Text(
              this.headerTitle,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.8)),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 16, bottom: 5, right:20),
            child: Text(
              "# Sentences: ${sentences.length}",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }
  Widget _startBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.tertiary,
          ),
          foregroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.onTertiary,
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.fromLTRB(20, 15, 20, 15),
          ),
        ),
        child: Text(
          "시작하기",
          style: Theme.of(context).textTheme.button!.copyWith(
                color: Theme.of(context).colorScheme.onTertiary,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        this._header(context),
        Expanded(
          child: Text("Hello"),
        ),
        Spacer(),
        this._startBtn(context),
      ],
    );
  }
}
