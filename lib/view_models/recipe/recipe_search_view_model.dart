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

  void onTapDetail(Recipe recipe) async {
    try {
      recipeModel.saveSpecificRecipe(recipe);
      context.go('/recipe/detail');
    } catch (e) {
      debugPrint('$e');
    }
  }

  void toggleFavorite(Recipe recipe) {
    int index = recipeModel.recipes.indexOf(recipe);
    if (index != -1) {
      bool? currentFavorite = recipeModel.recipes[index].isFavorite;
      debugPrint('Toggling favorite for ${recipe.name}: $currentFavorite');

      // `currentFavorite`이 null인지 확인
      recipeModel.recipes[index].isFavorite = !currentFavorite;
      debugPrint(
          'New favorite state: ${recipeModel.recipes[index].isFavorite}');

      notifyListeners();
    }
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
