import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/camera_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/objects/food.dart';
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

  void onPressClose() {
    context.pop();
    context.pop();
  }

  void onPressSelect() {
    isSelectState = !isSelectState;
    cameraModel.clearSelections();
    notifyListeners();
  }

  /// 냉장고 식재료 선택 함수
  void selectRefrigeratorFood(Food food) {
    if (isSelectState) {
      if (!cameraModel.selectedRefrigerator.contains(food)) {
        // selectedRefrigerator 없으면 새로 추가
        cameraModel.selectedRefrigerator.add(food);
      } else {
        // selectedRefrigerator 이미 추가 돼있으면 제거
        cameraModel.selectedRefrigerator.remove(food);
      }

      notifyListeners();
    }
  }

  /// 냉동고 식재료 선택 함수
  void selectFreezerFood(Food food) {
    if (isSelectState) {
      if (!cameraModel.selectedFreezer.contains(food)) {
        // selectedFreezer 없으면 새로 추가
        cameraModel.selectedFreezer.add(food);
      } else {
        // selectedFreezer 이미 추가 돼있으면 제거
        cameraModel.selectedFreezer.remove(food);
      }

      notifyListeners();
    }
  }

  /// 실온 식재료 선택 함수
  void selectRoomFood(Food food) {
    if (isSelectState) {
      if (!cameraModel.selectedRoom.contains(food)) {
        // selectedRoom 없으면 새로 추가
        cameraModel.selectedRoom.add(food);
      } else {
        // selectedRoom 이미 추가 돼있으면 제거
        cameraModel.selectedRoom.remove(food);
      }

      notifyListeners();
    }
  }

  void onPressedSave() async {
    isLoading = true;
    notifyListeners();

    if (isSelectState) {
      // 선택된 식재료 리스트에서 삭제
      cameraModel.deleteFoods();
      isSelectState = false;

      isLoading = false;
      notifyListeners();
    } else {
      // 식재료 등록
      await API.postFoods(cameraModel.analyzedFoods);

      // 식재료 리스트 다시 불러오기
      // id를 받아와야 하기 때문에 getFood를 실행해야 함
      await refrigeratorModel.getFoods();

      // 카메라 모델 초기화
      cameraModel.reset();

      isLoading = false;
      notifyListeners();

      // 냉장고 화면까지 pop 2번 해야됨
      // refrigerator/camera/add
      if (context.mounted) context.pop();
      if (context.mounted) context.pop();
    }
  }
}
