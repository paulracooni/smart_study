import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VideoUtils {
  static List<CameraDescription> cameras = [];
  static ResolutionPreset resolutionPreset = ResolutionPreset.medium;
  static CameraController? cameraController;
  static bool isCameraInitialized = false;

  static Future<void> initCamera({required void Function() callback}) async {
    if(!isCameraInitialized) {
      cameraController ??= CameraController(cameras[0], resolutionPreset);
      await cameraController!.initialize();
      isCameraInitialized = true;
      callback();
    }
  }

  static void disposeCamera() {
    if(isCameraInitialized) {
      cameraController!.dispose();
      isCameraInitialized = false;
      cameraController = null;

    }
  }
}
