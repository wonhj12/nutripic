import 'package:flutter/material.dart';
import 'package:nutripic/objects/ingredient.dart';
import 'package:nutripic/utils/palette.dart';

class RecipeIngredient extends StatelessWidget {
  final List<Ingredient> ingredients;

  const RecipeIngredient({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Palette.gray300, width: 0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          const Text(
            '재료',
            style: Palette.body1,
          ),
          const SizedBox(height: 4),

          Divider(thickness: 0.5, color: Palette.gray300),
          const SizedBox(height: 8),

          // 재료
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1), // 첫 번째 열 너비
              1: FlexColumnWidth(1), // 두 번째 열 너비
            },
            children: _buildIngredientRows(ingredients),
          ),
        ],
      ),
    );
  }

  List<TableRow> _buildIngredientRows(List<Ingredient> ingredients) {
    final List<TableRow> rows = [];
    for (int i = 0; i < ingredients.length; i += 2) {
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 12),
              child: _buildIngredientCell(ingredients[i]), // 첫 번째 열
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 12),
              child: i + 1 < ingredients.length
                  ? _buildIngredientCell(ingredients[i + 1]) // 두 번째 열
                  : Container(), // 빈 공간
            ),
          ],
        ),
      );
    }
    return rows;
  }

  Widget _buildIngredientCell(Ingredient ingredient) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ingredient.ingredientName, // 재료 이름
          style: Palette.subtitle2Medium.copyWith(color: Palette.gray500),
        ),
        Text(
          ingredient.amount, // 재료 수량
          style: Palette.subtitle2Medium.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
