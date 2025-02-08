import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/camera_model.dart';

class CameraConfirmViewModel with ChangeNotifier {
  CameraModel cameraModel;
  BuildContext context;
  CameraConfirmViewModel({
    required this.context,
    required this.cameraModel,
  });

  /// 이미지 선택 활성화
  bool isSelectable = false;

  /// 분석하기 버튼 활성화
  bool isAnalyzeBtnEnabled = true;

  /// 선택 버튼 클릭
  void onTapSelect() {
    isSelectable = true;
    notifyListeners();
  }

  /// 취소 버튼 클릭
  void onTapCancel() {
    // selectedImages 초기화
    cameraModel.selectedImages.clear();

    // 선택 종료
    isSelectable = false;
    notifyListeners();
  }

  /// 삭제 버튼 클릭
  void onTapDelete() {
    // 이미지 삭제
    cameraModel.removeImages();

    // 선택 종료
    // 이미지를 모두 지웠다면 버튼 비활성화
    isAnalyzeBtnEnabled = cameraModel.images.isNotEmpty;
    isSelectable = false;
    notifyListeners();
  }

  /// 이미지 선택
  void selectImage(int index) {
    if (isSelectable) {
      if (cameraModel.selectedImages.contains(index)) {
        // 이미 선택 상태라면 선택 해제
        cameraModel.selectedImages.remove(index);
      } else {
        // 선택 안된 상태면 선택
        cameraModel.selectedImages.add(index);
      }

      notifyListeners();
    }
  }

  /// 이미지 선택 됨 여부 확인
  bool isSelected(int index) => cameraModel.selectedImages.contains(index);

  /// 이미지 분석
  void onTapSend() {
    // 분석할 이미지가 있을 때만 작동
    if (cameraModel.images.isNotEmpty) {
      // 카메라 컨트롤러 제거
      cameraModel.controller?.dispose();

      context.pushReplacement('/refrigerator/loading');
    }
  }
}
