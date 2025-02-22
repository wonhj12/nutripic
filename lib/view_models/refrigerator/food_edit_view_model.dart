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

  final List<String> class1 = [
    '채소',
    '과일',
    '육류',
    '해산물',
    '버섯',
    '조미료',
    '빵류',
    '유제품',
    '달걀',
    '과자류',
    '곡물',
  ];
  final List<String> class2 = [
    '오이',
    '토마토',
    '아스파라거스',
    '아보카도',
    '브로콜리',
    '당근',
    '콜리플라워',
    '옥수수',
    '마늘',
    '대파',
    '상추',
    '양파',
    '감자',
    '고구마',
    '시금치',
    '사과',
    '바나나',
    '오렌지',
    '블루베리',
    '레몬',
    '라임',
    '망고',
    '배',
    '파인애플',
    '딸기',
    '소고기',
    '닭고기',
    '닭가슴살',
    '햄',
    '소시지',
    '생선',
    '새우',
    '버섯',
    '케찹',
    '잼',
    '마요네즈',
    '설탕',
    '소금',
    '식용유',
    '후추',
    '땅콩버터',
    '레몬즙',
    '고추장',
    '시치미',
    '식빵',
    '버터',
    '치즈',
    '우유',
    '요거트',
    '달걀',
    '초콜릿',
    '견과류',
    '쌀',
    '파스타',
  ];

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
