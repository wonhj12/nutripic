import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/camera_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/utils/api.dart';

class CameraAddViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  CameraModel cameraModel;
  BuildContext context;
  CameraAddViewModel({
    required this.refrigeratorModel,
    required this.cameraModel,
    required this.context,
  });

  bool isLoading = false;

  bool isSelectState = false;

  void onPressSelect() {
    isSelectState = !isSelectState;
    notifyListeners();
  }

  void onPressedSave() async {
    isLoading = true;
    notifyListeners();

    // 식재료 등록
    await API.postFoods([]);
    // 식재료 리스트 다시 불러오기
    // TODO: postFoods의 반환 값으로 로직 수정 필요
    // await refrigeratorModel.getFoods();

    isLoading = false;
    notifyListeners();

    if (context.mounted) context.pop();
  }
}
