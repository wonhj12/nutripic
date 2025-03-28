import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';

class SavedRecipeTile extends StatelessWidget {
  final Recipe recipe;
  const SavedRecipeTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 226,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Palette.gray00,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Palette.gray200)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              recipe.imageUrl,
              width: 148,
              height: 148,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 8),

          // 레시피 이름
          Text(recipe.name,
              style: Palette.subtitle1Medium.copyWith(color: Palette.gray900)),
          const SizedBox(height: 8),

          // 레시피 정보
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
    );
  }
}
