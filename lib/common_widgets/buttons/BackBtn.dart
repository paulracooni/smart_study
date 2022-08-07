import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/effects.dart';

class BackBtn extends StatelessWidget {
  void Function() onTap;
  BackBtn({Key? key, required this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: Effects.boxShadowEffect(context),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 12,
          ),
        ),
        onTap: () {
          onTap();
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
