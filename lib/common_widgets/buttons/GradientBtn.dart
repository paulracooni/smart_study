import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GradientBtn extends StatelessWidget {
  double width;
  double height;
  Widget child;
  void Function() onPressed;

  GradientBtn(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.width = 120,
      this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red, Colors.pink],
        ),
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const StadiumBorder(),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
