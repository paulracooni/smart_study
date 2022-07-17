import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContentItem extends StatelessWidget {
  /// Element widget of [ContentSelector]
  String item;

  ContentItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.keyboard_arrow_right,
            size: 28,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          SizedBox(
            width: 5,
          ),
          Text(item, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ContentSelector extends StatefulWidget {
  String name;
  List<String> items;

  ContentSelector({
    Key? key,
    required this.name,
    required this.items,
  }) : super(key: key);

  @override
  State<ContentSelector> createState() => _ContentSelectorState();
}

class _ContentSelectorState extends State<ContentSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top:16, bottom: 5),
          child: Text(
            widget.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8)
            ),
          ),
        ),
        Divider(
          height: 5,
          thickness: 1,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
        ),
        ...widget.items.map((item) {
          return ContentItem(item: item);
        }).toList()
      ],
    );
  }
}
