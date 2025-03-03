import 'package:flutter/material.dart';
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
}
