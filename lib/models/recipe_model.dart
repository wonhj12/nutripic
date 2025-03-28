import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/api.dart';

class RecipeModel with ChangeNotifier {
  /// 레시피 모델
  List<Recipe> recipes = [];
  Recipe? selectedRecipe;

  List<Recipe> bookmarkedRecipes = [];

  RecipeModel({this.recipes = const []});

  /// 레시피 전달하는 것.
  Future<void> getRecipes() async {
    try {
      final recipeIds = await API.getRecipes();
      final List<Recipe> recipes = await API.recipePreview(recipeIds);
      this.recipes = recipes;
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $stackTrace');
    }
  }

  /// 북마크된 레시피 가져오기
  Future<void> getBookmarkedRecipes() async {
    try {
      bookmarkedRecipes = await API.getBookmarkedRecipes();
    } catch (e) {
      debugPrint('Error in getBookmarkedRecipes: $e');
    }
  }

  void saveSelectedRecipe(Recipe recipe) {
    selectedRecipe = recipe;
  }

  void saveRecipes(List<Recipe> recipeList) {
    recipes = recipeList;
  }
}
