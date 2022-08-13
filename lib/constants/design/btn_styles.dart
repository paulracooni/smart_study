import 'package:flutter/material.dart';
import 'package:smart_care/constants/app_text_style.dart';

class BtnStyles{

  late BuildContext context;
  static final BtnStyles _instance = BtnStyles._privateConstructor();
  BtnStyles._privateConstructor();

  factory BtnStyles(BuildContext context) {
    _instance.context = context;
    return _instance;
  }

  ButtonStyle get onPrimary {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(50, 50),
      primary: Theme.of(context).colorScheme.onPrimary,
      onPrimary: Theme.of(context).colorScheme.primary,
      textStyle: AppTextStyle.button.copyWith(
          color: Theme.of(context).colorScheme.primary
      ),
    );
  }

  ButtonStyle get inactive {
    return ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
    );
  }


}

