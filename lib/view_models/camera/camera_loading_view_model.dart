import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/camera_model.dart';

class CameraLoadingViewModel with ChangeNotifier {
  CameraModel cameraModel;
  BuildContext context;

  CameraLoadingViewModel({required this.cameraModel, required this.context}) {
    analyzeImage();
  }

  /// 이미지 전송 후 GPT 인식한 식재료를 모델에 저장하는 함수
  void analyzeImage() async {
    // 이미지 분석
    await cameraModel.getAnalyzedImages();

    // 이미지 저장 후 최종 확인 페이지로 이동
    if (context.mounted) context.pushReplacement('/refrigerator/add');
  }
}
