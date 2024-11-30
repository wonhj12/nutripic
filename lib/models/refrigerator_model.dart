import 'package:flutter/material.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/api.dart';

enum StorageType {
  fridge(0),
  freezer(1),
  room(2);

  final int rawValue;
  const StorageType(this.rawValue);
}

class RefrigeratorModel with ChangeNotifier {
  /// 0 - fridge, 1 - freezer,  2 - room
  List<List<Food>> foods = [[], [], []];

  /// 음식 정보 가져와서 리스트에 저장
  Future<void> getFoods() async {
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
