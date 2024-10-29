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

  /// 냉장, 냉동, 실온
  int selected = 0;

  /// 식재료 선택 가능 여부
  bool isSelectable = false;

  // 식재료 더미 데이터 (나중에 RefrigeratorModel 생성해서 옮겨야함)
  List<Food> foods = [
    Food(
      name: '당근',
      count: 2,
      imageName: 'carrot',
      expireDate: DateTime(2024, 11, 11),
    ),
    Food(
      name: '닭가슴살',
      count: 1,
      imageName: 'chicken_breast',
      expireDate: DateTime(2024, 11, 6),
    ),
    Food(
      name: '당근',
      count: 2,
      imageName: 'carrot',
      expireDate: DateTime(2024, 11, 11),
    ),
    Food(
      name: '닭가슴살',
      count: 1,
      imageName: 'chicken_breast',
      expireDate: DateTime(2024, 11, 6),
    ),
    Food(
      name: '당근',
      count: 2,
      imageName: 'carrot',
      expireDate: DateTime(2024, 11, 11),
    ),
    Food(
      name: '닭가슴살',
      count: 1,
      imageName: 'chicken_breast',
      expireDate: DateTime(2024, 11, 6),
    ),
    Food(
      name: '당근',
      count: 2,
      imageName: 'carrot',
      expireDate: DateTime(2024, 11, 11),
    ),
    Food(
      name: '닭가슴살',
      count: 1,
      imageName: 'chicken_breast',
      expireDate: DateTime(2024, 11, 6),
    ),
    Food(
      name: '당근',
      count: 2,
      imageName: 'carrot',
      expireDate: DateTime(2024, 11, 11),
    ),
    Food(
      name: '닭가슴살',
      count: 1,
      imageName: 'chicken_breast',
      expireDate: DateTime(2024, 11, 6),
    ),
    Food(
      name: '당근',
      count: 2,
      imageName: 'carrot',
      expireDate: DateTime(2024, 11, 11),
    ),
    Food(
      name: '닭가슴살',
      count: 1,
      imageName: 'chicken_breast',
      expireDate: DateTime(2024, 11, 6),
    ),
  ];

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
    foods.removeWhere((food) => selectedFoods.contains(food));

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
    selected = 0;
    // 더미 데이터
    foods = [
      Food(
        name: '당근',
        count: 2,
        imageName: 'carrot',
        expireDate: DateTime(2024, 11, 11),
      ),
      Food(
        name: '닭가슴살',
        count: 1,
        imageName: 'chicken_breast',
        expireDate: DateTime(2024, 11, 6),
      ),
    ];
    notifyListeners();
  }

  /// 냉동 버튼 클릭시 호출되는 함수
  void onTapFreezer() {
    selected = 1;
    foods = refrigeratorModel.freezerFoods ?? [];
    notifyListeners();
  }

  /// 실온 버튼 클릭시 호출되는 함수
  void onTapCabinet() {
    selected = 2;
    foods = refrigeratorModel.cabinetFoods ?? [];
    notifyListeners();
  }
}
