import 'package:flutter/material.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/objects/recipe.dart';

class RecipeSearchViewModel extends ChangeNotifier {
  BuildContext context;
  RecipeModel recipeModel;

  RecipeSearchViewModel({
    required this.context,
    required this.recipeModel,
  }) {
    // 검색 결과 필터링
    filterRecipes();
  }

  List<Recipe> filteredRecipes = [];

  /// 검색된 레시피 이름
  String query = '';

  void onTapDetail(int idx) async {
    try {
      recipeModel.selectedRecipe = filteredRecipes[idx];
      context.go('/recipe/detail');
    } catch (e) {
      debugPrint('$e');
    }
  }

  void toggleFavorite(int idx) {
    filteredRecipes[idx].isFavorite = !filteredRecipes[idx].isFavorite;
    notifyListeners();
  }

  void filterRecipes() {
    filteredRecipes = recipeModel.recipes
        .where((recipe) => recipe.name.contains(query))
        .toList();
    notifyListeners();
  }

  void onRecipeView() {
    context.go('/recipe');
  }

  void onTextChanged(String value) {
    query = value;
    filterRecipes();
  }
}
