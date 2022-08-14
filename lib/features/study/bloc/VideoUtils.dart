import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VideoUtils {
  static List<CameraDescription> cameras = [];
  static ResolutionPreset resolutionPreset = ResolutionPreset.high;
  static CameraController? cameraController;
  static bool isCameraInitialized = false;
  static XFile? videoFile;

  static Future<void> initCamera({required void Function() callback}) async {
    if (!isCameraInitialized) {
      cameraController ??= CameraController(
        cameras[0],
        resolutionPreset,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await cameraController!.initialize();
      isCameraInitialized = true;
      videoFile = null;
      callback();
    }
  }

  static void disposeCamera() {
    if (isCameraInitialized) {
      cameraController!.dispose();
      isCameraInitialized = false;
      cameraController = null;
      videoFile = null;
    }
  }

  static void startVideoRecording() async {
    if (cameraController!.value.isRecordingVideo == false) {
      await cameraController!.startVideoRecording();
      videoFile = null;
    }
  }

  static void stopVideoRecording() async {
    if (cameraController!.value.isRecordingVideo == true) {
      videoFile = await cameraController!.stopVideoRecording();
      // html.window.open(videoFile.path, "_blank");
    }
  }

  static void pauseVideoRecording() async {
    if (cameraController!.value.isRecordingVideo == true) {
      await cameraController!.pauseVideoRecording();
    }
  }

  static XFile getVideoFile() {
    return videoFile!;
  }

  static void resumeVideoRecording() async {
    if (cameraController!.value.isRecordingPaused == true) {
      await cameraController!.resumeVideoRecording();
    }
  }
}
