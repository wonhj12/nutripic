import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';

class RecipeInfo extends StatelessWidget {
  final Recipe recipe;

  const RecipeInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 레시피 이름
        Text(
          recipe.name,
          style: TextStyle(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // 난이도, 소요 시간, 선호도
        Row(
          children: [
            // 난이도 (별)
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < recipe.difficulty ? Icons.star : Icons.star_border,
                  color: Colors.yellow[700],
                  size: 20,
                );
              }),
            ),
            const SizedBox(width: 16),
            // 소요 시간
            Text(
              "${recipe.cookingTime}분 이내",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 16),
            // 선호도 (즐겨찾기 아이콘)
            Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: recipe.isFavorite ? Colors.red : Colors.black,
              size: 20,
            ),
          ],
        ),
      ],
    );
  }
}
