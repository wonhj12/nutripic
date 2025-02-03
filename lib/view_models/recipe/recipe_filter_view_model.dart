import 'package:flutter/material.dart';
import 'package:nutripic/models/recipe_model.dart';

class RecipeFilterViewModel extends ChangeNotifier {
  RecipeModel recipeModel;
  BuildContext context;

  RecipeFilterViewModel({
    required this.recipeModel,
    required this.context,
  });

  // 필요에 따라 추가적인 메서드 및 로직을 여기에 작성할 수 있습니다.
}
