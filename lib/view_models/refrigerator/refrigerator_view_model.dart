import 'package:flutter/widgets.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/objects/food.dart';

class RefrigeratorViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  BuildContext context;
  RefrigeratorViewModel({
    required this.refrigeratorModel,
    required this.context,
  });

  /// 현재 선택된 냉장고
  StorageType storage = StorageType.fridge;

  /// 식재료 선택 가능 여부
  bool isSelectable = false;

  /// 선택된 식재료
  Set<Food> selectedFoods = <Food>{};

  /// 선택 버튼 클릭시 호출되는 함수
  /// <br /> 식재료 선택
  void onTapSelect() {
    isSelectable = true;
    notifyListeners();
  }

  /// 취소 버튼 클릭시 호출되는 함수
  /// <br /> 식재료 선택 취소
  void onTapCancel() {
    // selectedFoods 초기화
    selectedFoods.clear();

    // 선택 모드 종료
    isSelectable = false;
    notifyListeners();
  }

  /// 삭제 버튼 클릭시 호출되는 함수
  /// <br /> 식재료 삭제
  void onTapDelete() {
    // selectedFoods에 있는 식재료를 리스트에서 삭제
    refrigeratorModel.foods[storage.rawValue]
        .removeWhere((food) => selectedFoods.contains(food));

    // 삭제 후 selectedFoods 초기화
    selectedFoods.clear();

    // 선택 모드 종료
    isSelectable = false;
    notifyListeners();
  }

  /// 식재료 선택 함수
  void selectFood(Food food) {
    if (isSelectable) {
      if (!selectedFoods.contains(food)) {
        // selectedFoods에 없으면 새로 추가
        selectedFoods.add(food);
      } else {
        // selectedFoods에 이미 추가 돼있으면 제거
        selectedFoods.remove(food);
      }
      notifyListeners();
    }
  }

  /// 냉장 버튼 클릭시 호출되는 함수
  void onTapRefrigerator() {
    storage = StorageType.fridge;
    notifyListeners();
  }

  /// 냉동 버튼 클릭시 호출되는 함수
  void onTapFreezer() {
    storage = StorageType.freezer;
    notifyListeners();
  }

  /// 실온 버튼 클릭시 호출되는 함수
  void onTapCabinet() {
    storage = StorageType.room;
    notifyListeners();
  }
}
