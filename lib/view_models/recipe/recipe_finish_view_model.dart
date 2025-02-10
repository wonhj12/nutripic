import 'package:flutter/material.dart';
import 'package:nutripic/models/camera_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/enums/storage_type.dart';

class RecipeFinishViewModel extends ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  CameraModel cameraModel;
  BuildContext context;

  RecipeFinishViewModel({
    required this.refrigeratorModel,
    required this.cameraModel,
    required this.context,
  });

  /// 기존 `selectedFoods` 대신 별도 리스트 생성
  Set<Food> filterSelectedFoods = <Food>{};
  Set<Food> filterSelectedExpiredFoods = <Food>{};

  /// 식재료 선택 가능 여부
  bool isSelectable = false;

  /// 현재 선택된 냉장고 index
  StorageType get storage => refrigeratorModel.storage;

  /// 취소 버튼 클릭시 호출되는 함수
  /// <br /> 식재료 선택 취소
  void onTapCancel() {
    // 선택된 식재료 초기화
    refrigeratorModel.clearSelectedFoods();

    // 선택 모드 종료
    isSelectable = false;
    notifyListeners();
  }

  /// 필터 전용 식재료 선택 함수 (냉장고 데이터에 영향 X)
  void selectFood(Food food) {
    if (food.expired) {
      if (!filterSelectedExpiredFoods.contains(food)) {
        filterSelectedExpiredFoods.add(food);
      } else {
        filterSelectedExpiredFoods.remove(food);
      }
    } else {
      if (!filterSelectedFoods.contains(food)) {
        filterSelectedFoods.add(food);
      } else {
        filterSelectedFoods.remove(food);
      }
    }

    notifyListeners();
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
