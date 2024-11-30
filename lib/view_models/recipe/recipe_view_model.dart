import 'package:flutter/widgets.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

class RecipeViewModel with ChangeNotifier {
  RecipeModel recipeModel;
  BuildContext context;
  RecipeViewModel({
    required this.recipeModel,
    required this.context,
  }) {
    updateRecipes();
  }

  /// 레시피 상세 페이지로 이동
  void onTapDetail(Recipe recipe) {
    recipeModel.saveSpecificRecipe(recipe);
    context.go('/recipe/detail');
  }

  void onTapAll() {
    recipeModel.saveSpecificRecipe(Recipe(
        difficulty: 1,
        recipeName: 'qwer',
        minTime: 1,
        maxTime: 2,
        imageSource: 'asdf'));
    context.go('/recipe/detail');
  }

  /// 레시피 전달하는 것.
  void updateRecipes() {
    final random = Random();
    final Set<int> indices = {};

    while (indices.length < 4) {
      indices.add(random.nextInt(recipeList.length));
    }
    List<Recipe> recipes = indices.map((index) => recipeList[index]).toList();
    recipeModel.saveRecipes(recipes);
    notifyListeners();
  }
}

/// 더미 데이터
List<Recipe> recipeList = [
  Recipe(
      recipeName: "연어 계란 샐러드",
      difficulty: 2,
      minTime: 10,
      maxTime: 15,
      imageSource: 'assets/foods/salmon_egg_salad.png'),
  Recipe(
      recipeName: "단호박죽",
      difficulty: 3,
      minTime: 30,
      maxTime: 40,
      imageSource: 'assets/foods/pumpkin_soup.png'),
  Recipe(
      recipeName: "토마토 샐러드",
      difficulty: 1,
      minTime: 10,
      maxTime: 15,
      imageSource: 'assets/foods/tomato_salad.png'),
  Recipe(
      recipeName: "치즈 피자",
      difficulty: 2,
      minTime: 25,
      maxTime: 30,
      imageSource: 'assets/foods/cheese_pizza.png'),
  Recipe(
      recipeName: "페퍼로니 피자",
      difficulty: 3,
      minTime: 25,
      maxTime: 50,
      imageSource: 'assets/foods/pepperoni_pizza.png'),
  Recipe(
      recipeName: "하와이안 피자",
      difficulty: 2,
      minTime: 5,
      maxTime: 30,
      imageSource: 'assets/foods/hawaiian_pizza.png'),
  Recipe(
      recipeName: "고르곤졸라 피자",
      difficulty: 1,
      minTime: 25,
      maxTime: 35,
      imageSource: 'assets/foods/gorgonzola_pizza.png'),
  Recipe(
      recipeName: "불닭볶음면",
      difficulty: 1,
      minTime: 5,
      maxTime: 10,
      imageSource: 'assets/foods/buldak_noodle.png'),
];
