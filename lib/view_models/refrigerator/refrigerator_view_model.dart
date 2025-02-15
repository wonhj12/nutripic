import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/camera_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/enums/storage_type.dart';

class RefrigeratorViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  CameraModel cameraModel;
  BuildContext context;
  RefrigeratorViewModel({
    required this.refrigeratorModel,
    required this.cameraModel,
    required this.context,
  }) {
    initialize();
  }

  /// 식재료 선택 가능 여부
  bool isSelectable = false;

  /// 현재 선택된 냉장고 index
  StorageType get storage => refrigeratorModel.storage;

  /// 초기화
  void initialize() async {
    await refrigeratorModel.getFoods();
    notifyListeners();
  }

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
    await refrigeratorModel.deleteFoods();

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

  /// 카메라 호출 함수
  void onTapCamera() async {
    // 카메라 초기화
    cameraModel.reset();

    // 식재료 추가 후 냉장고 화면 업데이트를 위해서 비동기 처리
    await context.push('/refrigerator/camera');
    notifyListeners();
  }
}
