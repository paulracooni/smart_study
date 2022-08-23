import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_care/common_widgets/buttons/GradientBtn.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsState.dart';
import 'package:smart_care/features/study/models/StudyInfo.dart';
import 'package:smart_care/routes/route_name.dart';

import '../../study/StudyView.dart';

class ContentsPreview extends StatelessWidget {
  static const double _headerHeight = 75;

  const ContentsPreview({Key? key}) : super(key: key);

  Widget header(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isDesktop = displayMode == DisplayMode.DESKTOP;

    ContentsBloc contentsBloc = ContentsBloc.read(context);
    String headerName = contentsBloc.pickedInfo.getCurrentPick();
    List<String> sentences = contentsBloc.pickedInfo.sentences;
    return Container(
      width: double.infinity,
      height: isDesktop ? _headerHeight : 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Center(
                child: Text(
                  headerName,
                  style: isDesktop
                      ? AppTextStyle.h6
                      : AppTextStyle.h6.copyWith(
                          fontSize: 16,
                        ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Center(
                child: Text(
                  "${sentences.length}개 문장",
                  style: AppTextStyle.h6.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: isDesktop ? 20 : 16),
                ),
              ),
            ],
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
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isMobile = displayMode == DisplayMode.MOBILE;
    ContentsBloc contentsBloc = ContentsBloc.read(context);
    List<String> sentences = contentsBloc.pickedInfo.sentences;
    String headerName = contentsBloc.pickedInfo.getCurrentPick();

    return Container(
      margin: isMobile
          ? const EdgeInsets.only(right: 15, bottom: 15)
          : const EdgeInsets.only(right: 25, bottom: 40),
      decoration: BoxDecoration(
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: GradientBtn(
        onPressed: () => Navigator.pushNamed(
          context,
          RouteName.STUDY,
          arguments: StudyInfo(
            studyTitle: headerName,
            paragraphs: sentences,
          ),
        ),
        child: Text(
          "학습 시작하기",
          style: AppTextStyle.button.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ContentsBloc.consumer(
        builder: (BuildContext context, ContentsState state) {
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
                    SizedBox(
                      height: isDesktop ? _headerHeight - 10 : 45,
                    ),
                    Expanded(
                      child: state is IndexUpdatedState
                          ? preview(context)
                          : const Center(child: CircularProgressIndicator()),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    header(context),
                    const Spacer(),
                    if (state is IndexUpdatedState) studyStartBtn(context),
                  ],
                ),
              ],
            ),
          );
        },
      );
}
