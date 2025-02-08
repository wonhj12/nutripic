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
  });

  // 필요에 따라 추가적인 메서드 및 로직을 여기에 작성할 수 있습니다.

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

  void onRecipeView() {
    context.go('/recipe');
  }
}
