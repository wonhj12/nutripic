import 'package:flutter/material.dart';
import 'package:nutripic/components/recipe/recipe_card.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();

    if (recipeViewModel.recipeModel.recipes.isEmpty) {
      //recipeViewModel.updateRecipes();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          recipeViewModel.updateRecipes();
        },
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: recipeViewModel.recipeModel.recipes.length,
          itemBuilder: (context, index) {
            return RecipeCard(
                recipe: recipeViewModel.recipeModel.recipes[index]);
          },
        ),
      ),
    );
  }
}
