import 'package:flutter/material.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:nutripic/objects/ingredient.dart';
import 'package:nutripic/objects/recipe.dart';

class RecipeDetailViewModel extends ChangeNotifier {
  RecipeModel recipeModel;
  BuildContext context;

  RecipeDetailViewModel({
    required this.recipeModel,
    required this.context,
  });

  // 필요에 따라 추가적인 메서드 및 로직을 여기에 작성할 수 있습니다.
}
