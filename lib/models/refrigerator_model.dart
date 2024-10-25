import 'package:flutter/material.dart';
import 'package:nutripic/objects/food.dart';

class RefrigeratorModel with ChangeNotifier {
  /// 냉장고에 저장된 음식 리스트
  List<Food>? refrigeratorFoods;

  /// 냉장고에 저장된 음식 리스트
  List<Food>? freezerFoods;

  /// 냉장고에 저장된 음식 리스트
  List<Food>? cabinetFoods;
}
