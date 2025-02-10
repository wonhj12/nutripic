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
      width: MediaQuery.of(context).size.width * (343 / 375),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26, width: 0.7),
        color: Colors.white, // 투명한 흰색 배경
        borderRadius: BorderRadius.circular(16), // 모서리 둥글게
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "재료",
            style: TextStyle(
              fontSize: 18, // 제목 글꼴 크기 수정
              fontWeight: FontWeight.w600, // 강조된 제목
            ),
          ),
          const Divider(
            thickness: 1.0, // 구분선 두께 조정
            color: Colors.black26,
          ),
          const SizedBox(height: 8),
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
          style: Palette.subtitle2Medium
              .copyWith(color: Palette.gray500, fontWeight: FontWeight.w500),
        ),
        Text(
          ingredient.amount, // 재료 수량
          style: Palette.subtitle2Medium.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
