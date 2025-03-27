import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';

class RecipeInfo extends StatelessWidget {
  final Recipe recipe;

  final Function() onPressed;

  const RecipeInfo({super.key, required this.recipe, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 왼쪽: 레시피 이름과 난이도, 소요 시간
        Column(
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
                      size: 16, // 별 크기
                    );
                  }),
                ),
                SizedBox(width: 8),
                // 소요 시간
                Text(
                  '${recipe.cookingTime}분 이내',
                  style: Palette.caption1.copyWith(color: Palette.success),
                ),
              ],
            ),
          ],
        ),
        // 오른쪽: 즐겨찾기 버튼
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: recipe.isFavorite ? Palette.green500 : Palette.gray200,
            size: 24, // 하트 아이콘 크기
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
