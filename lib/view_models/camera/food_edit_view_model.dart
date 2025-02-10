import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/camera_model.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/enums/storage_type.dart';

class FoodEditViewModel with ChangeNotifier {
  CameraModel cameraModel;
  Food? food;
  StorageType? storage;
  BuildContext context;

  FoodEditViewModel({
    required this.cameraModel,
    this.food,
    this.storage,
    required this.context,
  }) {
    if (food != null && storage != null) {
      name.text = food!.name;
      selectedClass1 = food!.class1;
      selectedClass2 = food!.class2;
      selectedStorage = storage!;
    }
  }

  /// 식재료명 TextEditingController
  final TextEditingController name = TextEditingController();

  final List<String> class1 = ['채소'];
  final List<String> class2 = ['당근', '토마토', '감자'];
  final List<String> storages = [
    StorageType.fridge.name,
    StorageType.freezer.name,
    StorageType.room.name,
  ];

  String? selectedClass1;
  String? selectedClass2;
  StorageType? selectedStorage;

  /// Appbar 제목
  String appbarTitle() => food == null ? '식재료 등록하기' : '식재료 수정하기';

  /// 등록 버튼 레이블
  String editButtonLabel() => food == null ? '등록하기' : '수정하기';

  /// 대분류 드롭다운 선택
  void selectClass1(String? value) {
    if (value != null) {
      selectedClass1 = value;
    }
  }

  /// 소분류 드롭다운 선택
  void selectClass2(String? value) {
    if (value != null) {
      selectedClass2 = value;
    }
  }

  /// 저장소 드롭다운 선택
  void selectStorage(String? value) {
    if (value != null) {
      selectedStorage = StorageType.fromString(value);
    }
  }

  /// 등록하기 버튼 클릭
  void onPressedSave() {
    if (selectedClass1 != null &&
        selectedClass2 != null &&
        selectedStorage != null) {
      // 수정
      if (food != null && storage != null) {
        final index = cameraModel.analyzedFoods[storage!.rawValue]
            .indexWhere((food) => food == this.food);

        if (selectedStorage == storage) {
          // 저장 위치를 변경하지 않았다면 그대로 업데이트
          cameraModel.analyzedFoods[storage!.rawValue][index].update(
            name: name.text.trim(),
            class1: selectedClass1!,
            class2: selectedClass2!,
          );

          context.pop();
          return;
        } else {
          // 저장 위치를 변경했다면 기존 저장소에서 제거
          cameraModel.analyzedFoods[storage!.rawValue].removeAt(index);
        }
      }

      // 새 식재료 등록
      final newFood = Food(
        id: -1,
        name: name.text.trim(),
        icon: food?.icon ?? 'carrot',
        class1: selectedClass1!,
        class2: selectedClass2!,
        addedDate: food?.addedDate ?? DateTime.now(),
        expireDate: food?.expireDate ?? DateTime.now(),
        expired: food?.expired ?? false,
      );
      cameraModel.analyzedFoods[selectedStorage!.rawValue].add(newFood);

      context.pop();
    }
  }
}
