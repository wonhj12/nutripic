import 'package:flutter/material.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
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
          child: Container(
            margin: const EdgeInsets.only(bottom: 20), // 하단 여백
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10), // 내부 여백
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7), // 투명한 흰색 배경
              borderRadius: BorderRadius.circular(10), // 모서리 둥글게
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // 그림자 위치
                ),
              ],
            ),
            child: Text(
              recipe.recipeName, // 예: 레시피 제목
              style: const TextStyle(
                color: Colors.black, // 텍스트 색상
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // 텍스트 가운데 정렬
            ),
          ),
        ),
      ],
    );
  }
}
