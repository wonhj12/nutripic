import 'package:flutter/material.dart';
import 'package:nutripic/components/recipe/overlay_box.dart';
import 'package:nutripic/components/recipe/recipe_container.dart';
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

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            recipe.imageSource,
            fit: BoxFit.fitHeight,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: OverlayBox(
            margin: EdgeInsets.only(bottom: screenHeight * 0.02), // 하단 여백
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // 가로 패딩
              vertical: screenHeight * 0.01, // 세로 패딩
            ),
            width: screenWidth * 0.9, // 박스 너비
            height: screenHeight * 0.1, // 박스 높이
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
                        recipe.recipeName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.05, // 폰트 크기
                        ),
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
                                color: Colors.yellow[700],
                                size: screenWidth * 0.04, // 별 크기
                              );
                            }),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          // 소요 시간
                          Text(
                            "${recipe.minTime}-${recipe.maxTime}분",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 오른쪽: 즐겨찾기 버튼
                IconButton(
                  icon: Icon(
                    recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: recipe.isFavorite ? Colors.red : Colors.black,
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
    );
  }
}
