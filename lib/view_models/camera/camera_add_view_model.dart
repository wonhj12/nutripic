import 'package:flutter/material.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/utils/api.dart';

class CameraAddViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  CameraAddViewModel({required this.refrigeratorModel});

  void onPressedSave() async {
    // 인식한 식재료 등록
    if (refrigeratorModel.recognizedFoods.isNotEmpty) {
      // 임시로 dummy 처리
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

      await API.postFoods(foodList);

      // TODO: optimistic update 처리 필요
    }
  }
}
