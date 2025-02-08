import 'package:flutter/material.dart';
import 'package:nutripic/components/recipe/overlay_box.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();

    return Material(
      color: Colors.transparent, // 리플 효과를 위해 투명하게 설정
      child: InkWell(
        onTap: () {
          recipeViewModel.onTapDetail(recipe);
        },
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
              child: OverlayBox(
                margin:
                    EdgeInsets.only(bottom: screenHeight * (32 / 812)), // 하단 여백
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, // 가로 패딩
                  vertical: screenHeight * 0.01, // 세로 패딩
                ),
                width: screenWidth * (343 / 375), // 박스 너비
                height: screenHeight * (76 / 812), // 박스 높이
                child: Row(
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
                            style: Palette.title2Medium,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          // 난이도와 소요 시간
                          Row(
                            children: [
                              // 난이도 (별)
                              Row(
                                children: List.generate(5, (starIndex) {
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
                                style: Palette.caption1
                                    .copyWith(color: Palette.success),
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
                        context.read<RecipeViewModel>().toggleFavorite(recipe);
                      },
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
