import 'package:flutter/material.dart';
import 'package:smart_care/common_widgets/buttons/GradientBtn.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';

class ContentsPreview extends StatelessWidget {
  static const double _headerHeight = 75;

  const ContentsPreview({Key? key}) : super(key: key);

  Widget header(BuildContext context) {
    ContentsBloc contentsBloc = ContentsBloc.read(context);
    String headerName = contentsBloc.pickedInfo.getCurrentPick();
    List<String> sentences = contentsBloc.pickedInfo.sentences;
    return Container(
      width: double.infinity,
      height: _headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Text(
            headerName,
            style: AppTextStyle.h6,
          ),
          const Spacer(),
          Text(
            "# Sentences: ${sentences.length}",
            style: AppTextStyle.h6.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget preview(BuildContext context) {
    ContentsBloc contentsBloc = ContentsBloc.read(context);
    List<String> sentences = contentsBloc.pickedInfo.sentences;
    return SingleChildScrollView(
      child: Column(
        children: sentences
            .map(
              (sentence) => Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  boxShadow: Effects.boxShadowEffect(context),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(1),
                  ),
                ),
                child: Text(
                  sentence,
                  style: AppTextStyle.body.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget studyStartBtn(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right:25, bottom:40),
      decoration: BoxDecoration(
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: GradientBtn(
        child: Text(
          "학습 시작하기",
          style: AppTextStyle.button.copyWith(
            color: Colors.white,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isDesktop = displayMode == DisplayMode.DESKTOP;

    return Container(
      margin: isDesktop
          ? const EdgeInsets.fromLTRB(3.0, 0, 3.0, 3.0)
          : const EdgeInsets.fromLTRB(3.0, 0, 3.0, 3.0),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: _headerHeight - 10,
              ),
              Expanded(
                child: preview(context),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              header(context),
              const Spacer(),
              studyStartBtn(context),
            ],
          ),
        ],
      ),
    );
  }
}
