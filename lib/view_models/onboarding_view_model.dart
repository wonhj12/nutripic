import 'package:flutter/material.dart';
import 'package:nutripic/objects/food.dart';

class OnboardingViewModel with ChangeNotifier {
  BuildContext context;
  OnboardingViewModel({
    required this.context,
  });

  /// 알러지 선택 가능 여부
  bool isSelectable = true;

  // 알러지 더미 데이터
  List<Food> allergies = [
    Food(
      name: '당근',
      count: 0,
      imageName: 'carrot',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '당근',
      count: 0,
      imageName: 'carrot',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '당근',
      count: 0,
      imageName: 'carrot',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '당근',
      count: 0,
      imageName: 'carrot',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '당근',
      count: 0,
      imageName: 'carrot',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '당근',
      count: 0,
      imageName: 'carrot',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '당근',
      count: 0,
      imageName: 'carrot',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '당근',
      count: 0,
      imageName: 'carrot',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
    Food(
      name: '닭가슴살',
      count: 0,
      imageName: 'chicken_breast',
      expireDate: DateTime(0000, 00, 00),
    ),
  ];

  /// 선택된 식재료
  Set<Food> selectedAllergies = <Food>{};

  /// 알러지 선택 함수
  void selectAllergies(Food food) {
    if (!selectedAllergies.contains(food)) {
      // selectedAllergies에 없으면 새로 추가
      selectedAllergies.add(food);
    } else {
      // selectedAllergies에 이미 추가 돼있으면 제거
      selectedAllergies.remove(food);
    }
    notifyListeners();
  }
}
