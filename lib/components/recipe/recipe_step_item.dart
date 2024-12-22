// lib/components/recipe/recipe_step_item.dart
import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class RecipeStepItem extends StatelessWidget {
  final int stepNumber;
  final String stepDescription;

  const RecipeStepItem({
    super.key,
    required this.stepNumber,
    required this.stepDescription,
  });

  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 단계 번호
          SizedBox(
            width: 50,
            height: 50,
            child: Text(
              stepNumber.toString(),
              style: Palette.recipeOrder,
            ),
          ),
          const SizedBox(width: 6),
          // 단계 설명
          Expanded(
            child: Text(
              stepDescription,
              style: Palette.recipeStep,
            ),
          ),
        ],
      ),
    );
  }
}
