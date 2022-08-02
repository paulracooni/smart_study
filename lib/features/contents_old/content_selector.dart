import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'content_item.dart';

// ignore: must_be_immutable
class ContentSelector extends StatefulWidget {
  /// [name] will be displayed at Header of [ContentSelector].
  final String name;

  /// [items] is part of key value of contents_old.
  final List<String> items;

  ValueNotifier<int> controller;

  ContentSelector({
    Key? key,
    required this.name,
    required this.items,
    required this.controller,
  }) : super(key: key);

  @override
  State<ContentSelector> createState() => _ContentSelectorState();
}

class _ContentSelectorState extends State<ContentSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: Effects.boxShadowEffect(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 16, bottom: 5),
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.8)),
            ),
          ),
          Divider( //Divier, VerticalDivider.
            height: 1,
            thickness: 1,
            color: Theme.of(context)
                .colorScheme
                .onBackground
                .withOpacity(0.2),
          ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.items.asMap().entries.map((entry) {
                  int index = entry.key;
                  String item = entry.value;
                  return ContentItem(
                    item: item,
                    priority: index,
                    onTap: (tappedIndex) {},
                    controller: widget.controller,
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
