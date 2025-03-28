import 'package:flutter/material.dart';
import 'package:nutripic/components/user_info/saved_recipe_tile.dart';
import 'package:nutripic/objects/recipe.dart';

class BookmarkContainer extends StatelessWidget {
  final List<Recipe> recipes;
  const BookmarkContainer({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return recipes.isEmpty
        ? Center(
            child: Text('저장한 레시피가 없네요'),
          )
        : SizedBox(
            height: 224,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return SavedRecipeTile(recipe: recipes[index]);
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(width: 16), // 아이템 사이 간격
            ),
          );
  }
}
