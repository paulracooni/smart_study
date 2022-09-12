import 'dart:math';

import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:smart_care/common_widgets/buttons/GradientBtn.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/design/effects.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/contents/ContentsView.dart';
import 'package:smart_care/features/contents/bloc/ContentsBloc.dart';
import 'package:smart_care/features/contents/bloc/ContentsEvent.dart';
import 'package:smart_care/features/contents/bloc/ContentsState.dart';
import 'package:smart_care/features/study/models/StudyInfo.dart';
import 'package:smart_care/routes/route_name.dart';

import '../../study/StudyView.dart';

class ContentsPreview extends StatefulWidget {

  static const double _headerHeight = 100;
  final ViewMode viewMode;
  const ContentsPreview({Key? key, required this.viewMode}) : super(key: key);

  @override
  State<ContentsPreview> createState() => _ContentsPreviewState();
}

class _ContentsPreviewState extends State<ContentsPreview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget header(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isDesktop = displayMode == DisplayMode.DESKTOP;
    ContentsBloc contentsBloc = ContentsBloc.read(context);
    String headerName = contentsBloc.pickedInfo.getCurrentPick();
    return Container(
      width: double.infinity,
      height: ContentsPreview._headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        boxShadow: Effects.boxShadowEffect(context),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
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
                      "${contentsBloc.nSelectedSentences}개 문장",
                      style: AppTextStyle.h6.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: isDesktop ? 20 : 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              ElevatedButton(
                onPressed: contentsBloc.isAllSentencesSelected
                    ? () {
                        contentsBloc.add(
                            DeselectAllSentencesEvent(Random().nextInt(9999)));
                      }
                    : () {
                        contentsBloc.add(
                            SelectAllSentencesEvent(Random().nextInt(9999)));
                      },
                child: contentsBloc.isAllSentencesSelected
                    ? const Text('Deselect All')
                    : const Text('Select All'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  contentsBloc.add(
                      SelectSentencesRandomlyEvent(Random().nextInt(9999)));
                },
                child: const Text('Select 8 Sentences Randomly'),
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

    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    DisplayMode displayMode = MediaQuery.of(context).displayMode;

    return DragSelectGridView(
      itemCount: sentences.length,
      gridController: contentsBloc.sentencesSelector,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, //1 개의 행에 보여줄 item 개수
        childAspectRatio: displayMode == DisplayMode.DESKTOP
            ? aspectRatio * 10
            : aspectRatio * 24, //item 의 가로 1, 세로 2 의 비율
        mainAxisSpacing: 2, //수평 Padding
        crossAxisSpacing: 2, //수직 Padding
      ),
      itemBuilder: (BuildContext context, int index, bool selected) {
        return Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
                : Theme.of(context).colorScheme.background,
            boxShadow: Effects.boxShadowEffect(context),
            borderRadius: const BorderRadius.all(
              Radius.circular(1),
            ),
          ),
          child: Text(
            sentences[index],
            style: AppTextStyle.body.copyWith(
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackground),
          ),
        );
      },
    );
  }

  Widget studyStartBtn(BuildContext context) {
    DisplayMode displayMode = MediaQuery.of(context).displayMode;
    bool isMobile = displayMode == DisplayMode.MOBILE;
    ContentsBloc contentsBloc = ContentsBloc.read(context);
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
        onPressed: () {
          if(contentsBloc.selectedSentences.isNotEmpty) {
            Navigator.pushNamed(
              context,
              RouteName.STUDY,
              arguments: StudyInfo(
                studyTitle: headerName,
                paragraphs: contentsBloc.selectedSentences,
              ),
            );
          }
        },
        child: Text(
          widget.viewMode == ViewMode.practice?
          "연습 시작하기": "시험 시작하기",
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
                    const SizedBox(
                      height: ContentsPreview._headerHeight - 5,
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
