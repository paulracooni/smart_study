import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:smart_care/features/study/study_controller.dart';

late List<CameraDescription> cameras;

// ignore: must_be_immutable
class VideoScreen extends StatefulWidget {
  StudyController controller;
  VideoScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Future<void> cameraValue;

  @override
  void initState() {
    super.initState();
    cameraValue = widget.controller.cameraInit(
      cameras[0],
      resolutionPreset: ResolutionPreset.high,
    ).initialize();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.cameraDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: cameraValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(widget.controller.camera);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }
}
