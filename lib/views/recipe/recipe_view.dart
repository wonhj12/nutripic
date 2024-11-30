import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/recipe/food_filter.dart';
import 'package:nutripic/components/recipe/recipe_card.dart';
import 'package:nutripic/components/recipe/recipe_container.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(
        backButton: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          recipeViewModel.updateRecipes();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const FoodFilter(),
            const SizedBox(height: 12),
            RecipeContainer(
              recipes: recipeViewModel.recipeModel.recipes ?? [],
            ),
            const SizedBox(height: 32),
            InkWell(
              onTap: recipeViewModel.onTapAll,
              child: Container(
                color: Colors.white,
                child: const Text("전체 레시피 보기"),
              ),
            ),
            const SizedBox(height: 34)
          ],
        ),
      ),
    );
  }
}
