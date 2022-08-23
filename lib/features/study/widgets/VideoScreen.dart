import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/constants/app_text_style.dart';
import 'package:smart_care/constants/display_mode.dart';
import 'package:smart_care/features/study/bloc/StudyBloc.dart';
import 'package:smart_care/features/study/bloc/StudyEvent.dart';
import 'package:smart_care/features/study/bloc/StudyState.dart';
import 'package:smart_care/features/study/bloc/VideoUtils.dart';

// ignore: must_be_immutable
class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    VideoUtils.disposeCamera();
  }

  Widget paragraphCaption() => BlocBuilder<StudyBloc, StudyState>(
        builder: (BuildContext context, StudyState state) {
          if (state is StudyStartState || state is StudyPauseState) {
            StudyBloc studyBloc = StudyBloc.read(context);

            int index = state.paragraphIndex;
            int maxIndex = studyBloc.paragraphUtil.itemsCount - 1;
            index = maxIndex > index ? index : maxIndex;

            String paragraph = studyBloc.studyInfo.paragraphs[index];

            DisplayMode displayMode = MediaQuery.of(context).displayMode;
            bool isMobile = displayMode == DisplayMode.MOBILE;

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.black,
                  child: Text(
                    paragraph,
                    style: AppTextStyle.body.copyWith(
                      fontSize: isMobile? 16:24,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: VideoUtils.initCamera(
          callback: () {},
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(
            VideoUtils.cameraController!,
            child: paragraphCaption(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
