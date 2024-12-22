import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nutripic/components/camera/detection_box.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

class CameraViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  BuildContext context;
  CameraViewModel({
    required this.refrigeratorModel,
    required this.context,
  }) {
    _initialize();
  }

  bool isLoading = false;

  /* YOLO 관련 변수 */
  ModelObjectDetection? _model; // YOLO 모델
  int _camFrameRotation = 0; // 카메라 회전 각도
  bool isPredicting = false; // 예측 여부

  List<ResultObjectDetection> detectedFoods = []; // 최종 감지된 식재료

  /* 카메라 관련 */
  late List<CameraDescription> _cameras; // 사용 가능한 카메라 리스트
  late CameraController controller; // 카메라 컨트롤러

  bool isCameraLoaded = false; // 카메라 로딩 완료 여부
  bool canTakePicture = false; // 사진 촬영 가능 여부

  // 화면과 실제 카메라 크기가 다름
  // 실제 화면 대비 크기
  Size actualPreviewSize = Size.zero;

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
    isLoading = true;
    notifyListeners();

    // YOLO 모델 로드
    await loadModel();

    // 카메라 로드
    await loadCamera();

    isLoading = false;
    notifyListeners();
  }

  /// 카메라 로드
  Future loadCamera() async {
    // 사용 가능한 카메라 불러오기
    _cameras = await availableCameras();

    // 후면 카메라 선택
    int idx =
        _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.back);

    final camera = _cameras[idx];
    _camFrameRotation = Platform.isAndroid ? camera.sensorOrientation : 0;

    // 카메라 기본 설정
    // imageFormatGroup: ImageFormatGroup.jpeg,
    // 더 빠른 처리를 위해서 yuv420, bgra8888을 선택한 것 같음
    controller = CameraController(
      camera,
      ResolutionPreset.medium,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.yuv420
          : ImageFormatGroup.bgra8888,
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

    // 카메라 초기화 완료시 YOLO detection 시작
    if (isCameraLoaded) {
      // 실시간 개체 감지를 위한 stream 시작
      controller.startImageStream(onLatestImageAvailable);

      // actualPreviewSize 계산
      Size screenSize =
          context.mounted ? MediaQuery.of(context).size : Size.zero;
      double ratio = controller.value.aspectRatio;
      actualPreviewSize = Size(screenSize.width, screenSize.width * ratio);
    }
  }

  /// YOLO 모델 로드
  Future loadModel() async {
    try {
      // 모델 레이블에 따라서 클래스 개수도 바꿔야 함
      _model = await PytorchLite.loadObjectDetectionModel(
        'assets/model/tdl.torchscript',
        24,
        640,
        640,
        labelPath: 'assets/model/tdl.txt',
        objectDetectionModelType: ObjectDetectionModelType.yolov8,
      );

      debugPrint('Loaded YOLO model');
    } catch (e) {
      debugPrint('Error loading YOLO model: $e');
    }
  }

  /// 사진 촬영
  /// <br /> 촬영한 사진들은 images 리스트에 저장
  // TODO: 사진 촬영시 감지된 식재료들을 저장하는 로직 구현 필요
  void takePicture() async {
    // 카메라 init 오류 또는 사진 찍는 중
    if (!controller.value.isInitialized || controller.value.isTakingPicture) {
      return;
    }

    try {
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
      // 전면 전환
      int front = _cameras
          .indexWhere((c) => c.lensDirection == CameraLensDirection.front);
      controller.setDescription(_cameras[front]);
    } else {
      // 후면 전환
      int back = _cameras
          .indexWhere((c) => c.lensDirection == CameraLensDirection.back);
      controller.setDescription(_cameras[back]);
    }
  }

  /// 가장 마지막 화면을 기준으로 detection 진행
  void onLatestImageAvailable(CameraImage cameraImage) {
    // 카메라 화면에서 벗어나면 모델을 사용하지 않도록 mounted 확인
    if (!context.mounted) return;

    runFoodDetection(cameraImage);

    // 카메라 화면에서 벗어나면 모델을 사용하지 않도록 mounted 확인
    if (!context.mounted) return;
  }

  /// Detection 예측을 진행하는 함수
  void runFoodDetection(CameraImage cameraImage) async {
    // 지금 예측 중이라면 return
    if (isPredicting) return;

    // 카메라 화면에서 벗어나면 모델을 사용하지 않도록 mounted 확인
    if (!context.mounted) return;

    // 예측 진행 중이 아니라면 예측 진행
    isPredicting = true;
    notifyListeners();

    if (_model != null) {
      detectedFoods = await _model!.getCameraImagePrediction(
        cameraImage,
        rotation: _camFrameRotation,
      );
    }

    // 카메라 화면에서 벗어나면 모델을 사용하지 않도록 mounted 확인
    if (!context.mounted) return;

    // 예측 종료
    isPredicting = false;
    notifyListeners();
  }

  /// 감지된 식재료에 detection box 그리는 함수
  List<Widget> drawDetectionBoxes() {
    return detectedFoods
        .map((e) => DetectionBox(
              result: e,
              screenSize: actualPreviewSize,
            ))
        .toList();
  }
}

// https://pub.dev/packages/pytorch_lite
