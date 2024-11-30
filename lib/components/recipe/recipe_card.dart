import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [Palette.shadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              recipe.imageSource,
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(recipe.recipeName),
          Text("${recipe.difficulty}개"),
          Text("${recipe.minTime}분~${recipe.maxTime}분")
        ],
      ),
    );
  }
}
