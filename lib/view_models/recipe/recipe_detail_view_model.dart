import 'package:flutter/material.dart';
import 'package:nutripic/models/recipe_model.dart';

class RecipeDetailViewModel with ChangeNotifier {
  RecipeModel recipeModel;
  BuildContext context;

  RecipeDetailViewModel({required this.recipeModel, required this.context});

  void finish() {}
}
