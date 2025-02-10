import 'package:flutter/material.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/api.dart';
import 'package:nutripic/utils/enums/storage_type.dart';

class RefrigeratorModel with ChangeNotifier {
  /// 현재 선택된 냉장고
  StorageType storage = StorageType.fridge;

  /// 0 - fridge, 1 - freezer,  2 - room
  List<List<Food>> foods = [[], [], []];

  /// 유통기한 임박한 식재료
  ///
  /// 0 - fridge, 1 - freezer,  2 - room
  List<List<Food>> expiredFoods = [[], [], []];

  /// 선택된 식재료
  Set<Food> selectedFoods = <Food>{};

  /// 선택된 유통기한 임박 식재료
  Set<Food> selectedExpiredFoods = <Food>{};

  /// 모델을 초기화하는 함수
  void reset() {
    storage = StorageType.fridge;
    foods = [[], [], []];
    expiredFoods = [[], [], []];
    selectedFoods.clear();
    selectedExpiredFoods.clear();
  }

  /// 선택된 식재료 초기화
  void clearSelectedFoods() {
    selectedFoods.clear();
    selectedExpiredFoods.clear();
  }

  /// 음식 정보 가져와서 리스트에 저장
  Future<void> getFoods() async {
    // 초기화 진행
    reset();

    final response = await API.getFoods();

    // 유통기한 임박한 식재료 분리
    response.asMap().forEach((index, foodList) {
      for (final food in foodList) {
        if (food.expired) {
          expiredFoods[index].add(food);
        } else {
          foods[index].add(food);
        }
      }
    });
  }

  /// 현재 냉장고에 보유한 식재료가 있는지 여부
  bool hasFoods() =>
      foods[storage.index].isNotEmpty || expiredFoods[storage.index].isNotEmpty;

  /// 선택된 식재료 삭제
  Future<void> deleteFoods() async {
    try {
      // 삭제할 식재료 아이디 API로 전달
      final List<int> foodIds = selectedFoods.map((e) => e.id).toList() +
          selectedExpiredFoods.map((e) => e.id).toList();
      // Optimistic Update를 위해서 API 요청은 후처리로 진행
      await API.deleteFood(foodIds);

      // selectedFoods에 있는 식재료를 리스트에서 삭제
      foods[storage.rawValue]
          .removeWhere((food) => selectedFoods.contains(food));

      // selectedExpiredFoods에 있는 식재료를 리스트에서 삭제
      expiredFoods[storage.rawValue]
          .removeWhere((food) => selectedExpiredFoods.contains(food));

      // 삭제 후 선택된 식재료 초기화
      clearSelectedFoods();
    } catch (e) {
      debugPrint('Error on deleteFoods');
    }
  }
}
