import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/common/custom_dialog.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/utils/api.dart';

class SearchViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  BuildContext context;

  SearchViewModel({required this.refrigeratorModel, required this.context});

  TextEditingController controller = TextEditingController();

  List<Map<String, dynamic>> searchedFoods = [];

  /// 식재료 검색
  void search() async {
    searchedFoods = await API.getStorageSearch(controller.text.trim());
    notifyListeners();
  }

  /// 선택된 식재료 추가
  void onTapFood(int index) async {
    await customDialog(
      context: context,
      title: '해당 식재료를 추가하시겠어요?',
      detail: '식재료명: ${searchedFoods[index]['class2']}',
      onPressed: () async {
        // 식재료 아이디로 추가
        await API.postFoodsById(searchedFoods[index]['id']);

        // 식재료 리스트 다시 불러오기
        // id를 받아와야 하기 때문에 getFood를 실행해야 함
        await refrigeratorModel.getFoods();

        if (context.mounted) context.pop();
      },
    );
  }
}
