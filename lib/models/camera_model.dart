import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/api.dart';

class CameraModel with ChangeNotifier {
  /// 카메라 촬영을 위한 컨트롤러
  CameraController? controller;

  /// 카메라 로딩 완료 여부
  bool isCameraLoaded = false;

  /// 촬영한 이미지 리스트
  List<File> images = [];

  /// 선택된 이미지
  List<int> selectedImages = [];

  /// GPT 인식한 식재료
  List<List<Food>> analyzedFoods = [[], [], []];

  CameraModel({this.controller});

  /// 모델 초기화
  void reset() {
    // 카메라 컨트롤러 dispose
    controller?.dispose();

    // 카메라 로딩 초기화
    isCameraLoaded = false;

    // 이미지 삭제
    for (File image in images) {
      image.deleteSync();
    }

    // 이미지 리스트 초기화
    images.clear();

    // 선택된 이미지 인덱스 초기화
    selectedImages.clear();

    // 인식한 식재료 초기화
    analyzedFoods = [[], [], []];
  }

  /// 카메라 로드
  Future loadCamera() async {
    // 사용 가능한 카메라 불러오기
    final cameras = await availableCameras();

    // 후면 카메라 선택
    int idx =
        cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.back);
    final camera = cameras[idx];

    // 카메라 기본 설정
    controller = CameraController(
      camera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );
    controller?.setFlashMode(FlashMode.off);

    await controller?.initialize().catchError((e) {
      if (e is CameraException && e.code == 'CameraAccessDenied') {
        // 카메라 권한 설정
        debugPrint('Camera access denied');
      } else {
        // 카메라 오류
        debugPrint('Camera error: $e');
      }
    });

    // 카메라 로딩 완료 확인
    checkCameraLoaded();
  }

  /// 카메라 로딩 완료 여부 확인
  void checkCameraLoaded() {
    if (controller != null) {
      isCameraLoaded = controller!.value.isInitialized;
    }
  }

  /// 사진 촬영 가능 여부 확인
  /// <br /> controller가 존재하고, 초기화가 정상적으로 됐고, 사진 촬영 중이 아닌 상태인 경우에만 사진 촬영 가능
  bool canTakePicture() {
    return (controller != null &&
        controller!.value.isInitialized &&
        !controller!.value.isTakingPicture);
  }

  /// 촬영된 이미지 중 인덱스에 해당하는 이미지 제거
  void removeImages() {
    // 내림차 순으로 정렬
    // 그래야 index out of range 오류가 안남
    selectedImages.sort((a, b) => b.compareTo(a));

    // 파일 제거
    for (int i in selectedImages) {
      images[i].deleteSync();
      images.removeAt(i);
    }

    // 선택된 이미지 초기화
    selectedImages.clear();
  }

  /// 사진 전송 후 GPT 인식한 식재료 가져오는 함수
  Future<void> getAnalyzedImages() async {
    analyzedFoods = await API.postImageToFood(images.first);
  }
}
