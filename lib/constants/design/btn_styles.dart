import 'package:flutter/material.dart';

class BtnStyles{

  late BuildContext context;
  static final BtnStyles _instance = BtnStyles._privateConstructor();
  BtnStyles._privateConstructor();

  factory BtnStyles(BuildContext context) {
    _instance.context = context;
    return _instance;
  }

  ButtonStyle get inactive {
    return ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
    );
  }

  ButtonStyle get active {
    return ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
    );
  }
}

