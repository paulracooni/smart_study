import 'package:flutter/material.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsEvent.dart';

class ContentsItemSize {
  static const double width = 145;
  static const double height = 40;
}

class ContentsItem extends StatefulWidget {
  final String name;
  final String headerName;
  final int priority;
  // final void Function() onTap;

  const ContentsItem({
    Key? key,
    required this.name,
    required this.headerName,
    required this.priority,
    // required this.onTap,
  }) : super(key: key);

  @override
  State<ContentsItem> createState() => _ContentsItemState();
}

class _ContentsItemState extends State<ContentsItem> {
  @override
  Widget build(BuildContext context) {
    ContentsBloc contentsBloc = ContentsBloc.read(context);
    bool isSelected = widget.priority ==
        contentsBloc.contentsSelection.getIndexByHeaderName(widget.headerName);

    return InkWell(
      onTap: () {
        contentsBloc
            .add(UpdateIndexEvent(widget.headerName, widget.priority));
      },
      onHover: (value) {},
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: ContentsItemSize.width,
        height: ContentsItemSize.height,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: Effects.boxShadowEffect(context),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          widget.name,
          textAlign: TextAlign.center,
          style: AppTextStyle.button.copyWith(
            fontSize: 18,
            color: isSelected
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
