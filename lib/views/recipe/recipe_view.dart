import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/recipe/food_filter.dart';
import 'package:nutripic/components/recipe/recipe_card.dart';
import 'package:nutripic/components/recipe/recipe_container.dart';
import 'package:nutripic/main.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          recipeViewModel.updateRecipes();
        },
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: recipeViewModel.recipeModel.recipes.length,
          itemBuilder: (context, index) {
            return RecipeCard(recipe: recipeList[index]);
          },
        ),
      ),
    );
  }
}

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
