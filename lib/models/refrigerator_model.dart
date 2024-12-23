import 'package:flutter/material.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/api.dart';

class RefrigeratorModel with ChangeNotifier {
  /// 0 - fridge, 1 - freezer,  2 - room
  List<List<Food>> foods = [[], [], []];

  /// YOLO에서 인식한 식재료 리스트
  Set<String> recognizedFoods = {};

  /// 모델을 초기화하는 함수
  void reset() {
    foods = [[], [], []];
    recognizedFoods.clear();
  }

  /// YOLO에서 인식한 식재료 초기화
  void resetRecognition() {
    recognizedFoods.clear();
  }

  /// 인식된 식재료 추가
  void addRecognition(List<String> recognitions) {
    recognizedFoods.addAll(recognitions);
  }

  /// 음식 정보 가져와서 리스트에 저장
  Future<void> getFoods() async {
    // 초기화 진행
    reset();

    final response = await API.getFoods();

    for (var storage in response) {
      String storageType = storage['storage'];
      List<dynamic> foodList = storage['foods'];

      if (foodList.isNotEmpty) {
        List<Food> parsedFoods =
            foodList.map((food) => Food.fromJson(food)).toList();

        switch (storageType) {
          case 'fridge':
            foods[0].addAll(parsedFoods);
            break;
          case 'freezer':
            foods[1].addAll(parsedFoods);
            break;
          case 'room':
            foods[2].addAll(parsedFoods);
            break;
        }
      }
    }
  }
}
