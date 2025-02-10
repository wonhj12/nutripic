import 'package:flutter/material.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/objects/recipe.dart';

class RecipeDetailViewModel extends ChangeNotifier {
  RecipeModel recipeModel;
  BuildContext context;

  RecipeDetailViewModel({
    required this.recipeModel,
    required this.context,
  });

  void onRecipeFinish() {
    context.go('/recipe/finish');
  }

  // 즐겨찾기 상태를 토글하는 메서드
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

  // 필요에 따라 추가적인 메서드 및 로직을 여기에 작성할 수 있습니다.
}
