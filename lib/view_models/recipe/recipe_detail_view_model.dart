import 'package:flutter/material.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:go_router/go_router.dart';

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

  // 필요에 따라 추가적인 메서드 및 로직을 여기에 작성할 수 있습니다.
}
