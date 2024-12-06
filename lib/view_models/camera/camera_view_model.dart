import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nutripic/models/refrigerator_model.dart';

class CameraViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  BuildContext context;
  CameraViewModel({
    required this.refrigeratorModel,
    required this.context,
  }) {
    _initialize();
  }

  late List<CameraDescription> _cameras; // 사용 가능한 카메라 리스트
  late CameraController controller; // 카메라 컨트롤러

  bool isLoading = false;
  bool isCameraLoaded = false; // 카메라 로딩 완료 여부
  bool canTakePicture = false; // 사진 촬영 가능 여부

  /// 촬영한 이미지 리스트
  List<File> images = [];

  @override
  void dispose() {
    // 카메라 controller 해제
    controller.dispose();
    super.dispose();
  }

  /// 초기 설정
  Future<void> _initialize() async {
    // 사용 가능한 카메라 불러오기
    _cameras = await availableCameras();

    // 카메라 기본 설정
    controller = CameraController(
      _cameras[0],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    await controller.initialize().catchError((e) {
      if (e is CameraException && e.code == 'CameraAccessDenied') {
        // 카메라 권한 설정
        debugPrint('Camera access denied');
      } else {
        // 카메라 오류
        debugPrint('Camera error: $e');
      }
    });

    // 카메라 설정 완료
    isCameraLoaded = controller.value.isInitialized;
    canTakePicture = isCameraLoaded;
    notifyListeners();
  }

  /// 사진 촬영
  /// 촬영한 사진을 임시 저장 디렉토리에 저장 후 주소 반환
  void takePicture() async {
    // 카메라 init 오류 또는 사진 찍는 중
    if (!controller.value.isInitialized || controller.value.isTakingPicture) {
      return;
    }

    try {
      // 임시 저장 장소와 이름 생성
      // Directory directory = await getTemporaryDirectory();
      // final imgPath = '${directory.path}/${DateTime.now()}.jpeg';

      // 사진 촬영
      XFile file = await controller.takePicture();
      images.add(File(file.path));

      notifyListeners();
    } catch (e) {
      // 사진 촬영 오류
      debugPrint('Error taking picture: $e');
    }
  }

  /// 카메라 전환
  void changeCameraDirection() {
    if (controller.description.lensDirection == CameraLensDirection.back) {
      controller.setDescription(_cameras[0]);
    } else {
      controller.setDescription(_cameras[1]);
    }
  }
}
