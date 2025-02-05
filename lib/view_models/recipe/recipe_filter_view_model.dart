import 'package:flutter/material.dart';
import 'package:nutripic/models/camera_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/enums/storage_type.dart';

class RecipeFilterViewModel extends ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  CameraModel cameraModel;
  BuildContext context;

  RecipeFilterViewModel({
    required this.refrigeratorModel,
    required this.cameraModel,
    required this.context,
  });

  /// 식재료 선택 가능 여부
  bool isSelectable = false;

  /// 현재 선택된 냉장고 index
  StorageType get storage => refrigeratorModel.storage;

  /// 선택 버튼 클릭시 호출되는 함수
  /// <br /> 식재료 선택
  void onTapSelect() {
    isSelectable = true;
    notifyListeners();
  }

  /// 취소 버튼 클릭시 호출되는 함수
  /// <br /> 식재료 선택 취소
  void onTapCancel() {
    // 선택된 식재료 초기화
    refrigeratorModel.clearSelectedFoods();

    // 선택 모드 종료
    isSelectable = false;
    notifyListeners();
  }

  /// 삭제 버튼 클릭시 호출되는 함수
  /// <br /> 식재료 삭제
  void onTapDelete() async {
    refrigeratorModel.deleteFoods();

    // 선택 모드 종료
    isSelectable = false;
    notifyListeners();
  }

  /// 식재료 선택 함수
  void selectFood(Food food) {
    if (isSelectable) {
      if (food.expired) {
        if (!refrigeratorModel.selectedExpiredFoods.contains(food)) {
          // selectedFoods에 없으면 새로 추가
          refrigeratorModel.selectedExpiredFoods.add(food);
        } else {
          // selectedFoods에 이미 추가 돼있으면 제거
          refrigeratorModel.selectedExpiredFoods.remove(food);
        }
      } else {
        if (!refrigeratorModel.selectedFoods.contains(food)) {
          // selectedFoods에 없으면 새로 추가
          refrigeratorModel.selectedFoods.add(food);
        } else {
          // selectedFoods에 이미 추가 돼있으면 제거
          refrigeratorModel.selectedFoods.remove(food);
        }
      }

      notifyListeners();
    }
  }

  /// 냉장 버튼 클릭시 호출되는 함수
  void onTapRefrigerator() {
    refrigeratorModel.storage = StorageType.fridge;
    notifyListeners();
  }

  /// 냉동 버튼 클릭시 호출되는 함수
  void onTapFreezer() {
    refrigeratorModel.storage = StorageType.freezer;
    notifyListeners();
  }

  /// 실온 버튼 클릭시 호출되는 함수
  void onTapCabinet() {
    refrigeratorModel.storage = StorageType.room;
    notifyListeners();
  }
}
