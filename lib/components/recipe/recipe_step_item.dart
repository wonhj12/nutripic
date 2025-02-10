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
    return Padding(
      padding: const EdgeInsets.only(bottom: 56),
      child: Row(
        children: [
          // 단계 번호
          Text(
            stepNumber.toString(),
            style: Palette.recipeOrder,
          ),
          const SizedBox(width: 12), // 간격 추가
          // 단계 설명
          Expanded(
            child: Text(
              stepDescription,
              style: Palette.body1,
            ),
          ),
        ],
      ),
    );
  }
}
