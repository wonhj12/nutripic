import 'package:flutter/material.dart';
import 'package:nutripic/models/camera_model.dart';

class CameraLoadingViewModel with ChangeNotifier {
  CameraModel cameraModel;
  BuildContext context;

  CameraLoadingViewModel({required this.cameraModel, required this.context});
}
