import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_care/constants/app_text_style.dart';
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
            int maxIndex = studyBloc.paragraphUtil.itemsCount-1 as int;
            index = maxIndex > index ? index: maxIndex;

            String paragraph = studyBloc
                .studyInfo.paragraphs[index];

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
                      fontSize: 24,
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
        callback: () {
          StudyBloc studyBloc = StudyBloc.read(context);
          studyBloc.add(StudyReadyEvent());
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // studyBloc.add(StudyReadyEvent());
          // print(VideoUtils.isCameraInitialized);
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
