import 'package:flutter/material.dart';
import 'package:nutripic/components/recipe/overlay_box.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';

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
            margin: EdgeInsets.only(
                bottom: screenHeight * 0.02), // 하단 여백을 화면 높이의 5%로 설정
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, // 가로 패딩을 화면 너비의 5%로 설정
              vertical: screenHeight * 0.02, // 세로 패딩을 화면 높이의 2%로 설정
            ),
            width: screenWidth * 0.9, // 박스 너비를 화면 너비의 90%로 설정
            height: screenHeight * 0.1, // 박스 높이를 화면 높이의 10%로 설정
            child: Center(
              child: Text(
                recipe.recipeName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.05, // 폰트 크기를 화면 너비의 5%로 설정
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
