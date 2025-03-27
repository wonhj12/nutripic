import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  final Function() onTap;

  final Function() like;

  const RecipeCard(
      {super.key,
      required this.recipe,
      required this.onTap,
      required this.like});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // 리플 효과를 위해 투명하게 설정
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            // 배경 이미지
            Positioned.fill(
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.fitHeight, // 이미지가 화면을 꽉 채우도록 설정
              ),
            ),

            // 오버레이 박스
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 32), // 하단 여백
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                width: double.infinity,
                height: 76,
                decoration: BoxDecoration(
                    color: Palette.gray00.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
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
                          style: Palette.title2Medium,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 4),

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
                              style: Palette.caption1
                                  .copyWith(color: Palette.success),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // 오른쪽: 즐겨찾기 버튼
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: recipe.isFavorite
                            ? Palette.green500
                            : Palette.gray200,
                        size: 24,
                      ),
                      onPressed: like,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
