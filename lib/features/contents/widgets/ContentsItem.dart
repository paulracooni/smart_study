import 'package:flutter/material.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
class ContentsItemSize {
  static const double width = 145;
  static const double height = 40;
}
class ContentsItem extends StatelessWidget {
  final String name;
  final int priority;
  final void Function() onTap;
  const ContentsItem({
    Key? key,
    required this.name,
    required this.priority,
    required this.onTap,
  }) : super(key: key);

  void wrappedOnTap() {
    onTap();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: wrappedOnTap,
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
          name,
          textAlign: TextAlign.center,
          style: AppTextStyle.button.copyWith(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
