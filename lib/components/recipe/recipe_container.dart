import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/components/recipe/recipe_card.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeContainer extends StatelessWidget {
  final List<Recipe> recipes;
  const RecipeContainer({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 164 / 240),
        children: [
          InkWell(
            onTap: () => recipeViewModel.onTapDetail(recipes[0]),
            child: RecipeCard(
              recipe: recipes[0],
            ),
          ),
          InkWell(
            onTap: () => recipeViewModel.onTapDetail(recipes[1]),
            child: RecipeCard(
              recipe: recipes[1],
            ),
          ),
          InkWell(
            onTap: () => recipeViewModel.onTapDetail(recipes[2]),
            child: RecipeCard(
              recipe: recipes[2],
            ),
          ),
          InkWell(
            onTap: () => recipeViewModel.onTapDetail(recipes[3]),
            child: RecipeCard(
              recipe: recipes[3],
            ),
          ),
        ],
      ),
    );
  }
}
