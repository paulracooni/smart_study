import 'package:flutter/material.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';

import 'VideoScreen.dart';

class VideoVew extends StatelessWidget {
  const VideoVew({Key? key}) : super(key: key);

  Widget layout(BuildContext context, {required Widget child}) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isDesktop = displayMode == DisplayMode.DESKTOP;
    return Container(
      margin: isDesktop
          ? const EdgeInsets.only(right: 5)
          : const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: child,
    );
  }

  Widget header(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          "Video Header",
          style: AppTextStyle.h5.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return layout(
      context,
      child: Column(
        children: [
          header(context),
          const Expanded(
              child: Center(
            child: VideoScreen(),
          )),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: const [
                Text("Button1"),
                Text("Button2"),
                Text("Button3"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
