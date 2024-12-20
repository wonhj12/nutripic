import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';

class RecipeModel with ChangeNotifier {
  /// 레시피 모델
  List<Recipe> recipes;
  Recipe? specificRecipe;

  RecipeModel({this.recipes = const []});

  void saveSpecificRecipe(Recipe recipe) {
    specificRecipe = recipe;
  }

  void saveRecipes(List<Recipe> recipeList) {
    recipes = recipeList;
  }
}
