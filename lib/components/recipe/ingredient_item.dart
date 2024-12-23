import 'package:flutter/material.dart';
import 'package:nutripic/objects/ingredient.dart';
import 'package:nutripic/utils/palette.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientItem({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ingredient.ingredientName,
            style: Palette.body,
          ),
          const SizedBox(width: 8),
          Text(
            ingredient.amount,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
