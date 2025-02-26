import 'package:flutter/material.dart';
import 'package:nutripic/models/refrigerator_model.dart';

class SearchViewModel with ChangeNotifier {
  RefrigeratorModel refrigeratorModel;
  BuildContext context;

  SearchViewModel({required this.refrigeratorModel, required this.context});
}
