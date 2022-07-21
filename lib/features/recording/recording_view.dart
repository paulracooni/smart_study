import 'package:flutter/material.dart';
import 'package:smart_care/constants/design/effects.dart';

class RecordingView extends StatelessWidget {
  const RecordingView({Key? key}) : super(key: key);

  Widget _backBtn(BuildContext context) {
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
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    const double marginHorizontal = 80.0;
    const double marginVertical = 40.0;

    return Scaffold(
      body: Stack(children: [
        Container(
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
          margin: const EdgeInsets.symmetric(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
          width: double.infinity,
          height: double.infinity,
          child: SizedBox(),
        ),
        _backBtn(context),


      ]),
    );
  }
}
