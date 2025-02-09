import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_detail_view_model.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeInfo extends StatelessWidget {
  final Recipe recipe;

  const RecipeInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 화면 크기 정보 가져오기

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 왼쪽: 레시피 이름과 난이도, 소요 시간
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 레시피 이름
              Text(
                recipe.name,
                style: Palette.title1SemiBold,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              // 난이도와 소요 시간
              Row(
                children: [
                  // 난이도 (별)
                  Row(
                    children: List.generate(3, (starIndex) {
                      return Icon(
                        starIndex < recipe.difficulty
                            ? Icons.star
                            : Icons.star_border,
                        color: Palette.green600,
                        size: screenWidth * 0.04, // 별 크기
                      );
                    }),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  // 소요 시간
                  Text(
                    "${recipe.cookingTime}분 이내",
                    style: Palette.caption1.copyWith(color: Palette.success),
                  ),
                ],
              ),
            ],
          ),
        ),
        // 오른쪽: 즐겨찾기 버튼
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: recipe.isFavorite ? Colors.red : Colors.black26,
            size: screenWidth * 0.07, // 하트 아이콘 크기
          ),
          onPressed: () {
            // 즐겨찾기 상태 토글
            context.read<RecipeDetailViewModel>().toggleFavorite(recipe);
          },
        ),
      ],
    );
  }
}
