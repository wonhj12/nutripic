import 'package:flutter/material.dart';

class OnboardingViewModel with ChangeNotifier {
  BuildContext context;
  OnboardingViewModel({
    required this.context,
  });

  // 알러지 더미 데이터
  List<String> allergies = [
    '난류(가금류)',
    '호두',
    '우유',
    '땅콩',
    '메밀',
    '잣',
    '밀',
    '복숭아',
    '대두',
    '토마토',
    '돼지고기',
    '쇠고기',
    '닭고기',
    '고등어',
    '새우'
  ];

  /// 선택된 식재료
  Set<String> selectedAllergies = {};

  /// 알러지 선택 함수
  void selectAllergies(String allergy) {
    if (!selectedAllergies.contains(allergy)) {
      // selectedAllergies에 없으면 새로 추가
      selectedAllergies.add(allergy);
    } else {
      // selectedAllergies에 이미 추가 돼있으면 제거
      selectedAllergies.remove(allergy);
    }
    notifyListeners();
  }

  /// 알러지 선택 여부 확인 함수
  bool isAllergySelected(String allergy) {
    return selectedAllergies.contains(allergy);
  }
}
