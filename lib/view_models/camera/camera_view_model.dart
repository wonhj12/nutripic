import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/camera_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';

class CameraViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  CameraModel cameraModel;
  BuildContext context;

  CameraViewModel({
    required this.refrigeratorModel,
    required this.cameraModel,
    required this.context,
  }) {
    _initialize();
  }

  bool isLoading = false; // 화면 로딩

  /// 초기 설정
  Future<void> _initialize() async {
    isLoading = true;
    notifyListeners();

    // 카메라 로드
    await cameraModel.loadCamera();

    isLoading = false;
    notifyListeners();
  }

  /// 사진 촬영
  /// <br /> 촬영한 사진들은 images 리스트에 저장
  void takePicture() async {
    // 카메라 init 오류 또는 사진 찍는 중이면 사진 촬영 불가능
    if (!cameraModel.canTakePicture()) {
      debugPrint('Controller not initialized or is currently taking picture');
      return;
    }

    try {
      // 사진 촬영 후 이미지 저장
      XFile file = await cameraModel.controller!.takePicture();
      cameraModel.images.add(File(file.path));
      notifyListeners();
    } catch (e) {
      // 사진 촬영 오류
      debugPrint('Error taking picture: $e');
    }
  }

  /// 식재료 추가 확인 페이지로 이동
  void onTapComplete() {
    // 촬영한 사진이 있을 때만 이동
    if (cameraModel.images.isNotEmpty) {
      context.push('/refrigerator/camera/confirm');
    }
  }

  /// 카메라 종료
  void onPressedClose() {
    cameraModel.reset();
    context.pop();
  }
}
