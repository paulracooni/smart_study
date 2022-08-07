import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    StudyBloc studyBloc = StudyBloc.read(context);
    return FutureBuilder(
      future: VideoUtils.initCamera(
          callback: () {
            studyBloc.add(StudyReadyEvent());
          },
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // studyBloc.add(StudyReadyEvent());
          // print(VideoUtils.isCameraInitialized);
          return CameraPreview(
            VideoUtils.cameraController!,
            child: const Center(
              child: Text("Whats In here"),
            ),
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
