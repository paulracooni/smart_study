import 'package:flutter/material.dart';

class Effects {

  static List<BoxShadow> boxShadowEffect(context) {
    Color shadowColor = Theme.of(context).colorScheme.shadow.withOpacity(0.3);
    return [
      BoxShadow(
        color: shadowColor,
        spreadRadius: 0,
        blurRadius: 2,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ];
  }
}
