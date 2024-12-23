import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/utils/api.dart';

class CameraAddViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  BuildContext context;
  CameraAddViewModel({required this.refrigeratorModel, required this.context});

  bool isLoading = false;

  void onPressedSave() async {
    isLoading = true;
    notifyListeners();

    // 인식한 식재료 등록
    if (refrigeratorModel.recognizedFoods.isNotEmpty) {
      // 임시로 dummy 처리
      // TODO: 로직 수정 필요
      final List<Map<String, dynamic>> foodList =
          refrigeratorModel.recognizedFoods
              .map((food) => {
                    'storageType': 'fridge',
                    'name': food,
                    'class1': 'class1',
                    'class2': 'class2',
                    'icon': 'carrot',
                    'addedDate':
                        '${DateTime.now().toIso8601String().split('.')[0]}Z',
                    'expireDate':
                        '${DateTime.now().toIso8601String().split('.')[0]}Z',
                    'expired': false
                  })
              .toList();

      // 식재료 등록
      await API.postFoods(foodList);
      // 식재료 리스트 다시 불러오기
      // TODO: postFoods의 반환 값으로 로직 수정 필요
      // await refrigeratorModel.getFoods();

      isLoading = false;
      notifyListeners();

      if (context.mounted) context.pop();
    }
  }
}
