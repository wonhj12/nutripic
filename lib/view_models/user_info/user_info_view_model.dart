import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/models/user_model.dart';

class UserInfoViewModel with ChangeNotifier {
  UserModel userModel;
  RefrigeratorModel refrigeratorModel;
  RecipeModel recipeModel;
  BuildContext context;

  UserInfoViewModel({
    required this.userModel,
    required this.refrigeratorModel,
    required this.recipeModel,
    required this.context,
  }) {
    initialize();
  }

  void initialize() async {
    await recipeModel.getBookmarkedRecipes();
    await refrigeratorModel.getRecentFoods();
    notifyListeners();
  }

  /// 프로필 수정 페이지로 이동
  void onTapEdit() async {
    await context.push('/user/edit');
    notifyListeners();
  }
}
