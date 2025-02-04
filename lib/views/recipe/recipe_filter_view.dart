import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/refrigerator_container.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_container.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_filter_view_model.dart';
import 'package:nutripic/view_models/refrigerator/refrigerator_view_model.dart';
import 'package:provider/provider.dart';

class RecipeFilterView extends StatelessWidget {
  const RecipeFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeFilterViewModel recipeFilterViewModel =
        context.watch<RecipeFilterViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(backButton: false),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 26),

              // 냉장고
              RefrigeratorContainer(
                foods: recipeFilterViewModel.refrigeratorModel
                    .foods[recipeFilterViewModel.storage.rawValue],
                expiredFoods: recipeFilterViewModel.refrigeratorModel
                    .expiredFoods[recipeFilterViewModel.storage.rawValue],
                selectedFoods:
                    recipeFilterViewModel.refrigeratorModel.selectedFoods,
                selectedExpiredFoods: recipeFilterViewModel
                    .refrigeratorModel.selectedExpiredFoods,
                isSelectable: recipeFilterViewModel.isSelectable = true,
                addFood: recipeFilterViewModel.onTapCamera,
                selectFood: recipeFilterViewModel.selectFood,
              ),

              const SizedBox(height: 16),
            ],
          ),
          // 냉장고 선택 버튼
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RefrigeratorSelectContainer(
                selected: recipeFilterViewModel.storage,
                onTapRefrigerator: recipeFilterViewModel.onTapRefrigerator,
                onTapFreezer: recipeFilterViewModel.onTapFreezer,
                onTapCabinet: recipeFilterViewModel.onTapCabinet,
              ),
              const SizedBox(height: 24),
            ],
          ),

          // 선택된 식재료 및 "적용하기" 버튼
          if (recipeFilterViewModel.refrigeratorModel.selectedFoods.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 선택된 식재료 표시
                Container(
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeFilterViewModel
                        .refrigeratorModel.selectedFoods.length,
                    itemBuilder: (context, index) {
                      final food = recipeFilterViewModel
                          .refrigeratorModel.selectedFoods
                          .elementAt(index);
                      return Chip(
                        label: Text(food.name),
                        onDeleted: () {
                          recipeFilterViewModel.selectFood(food);
                        },
                      );
                    },
                  ),
                ),

                // "적용하기" 버튼
                ElevatedButton(
                  onPressed: () {
                    // 선택된 식재료 반환
                    Navigator.pop(
                        context,
                        recipeFilterViewModel.refrigeratorModel.selectedFoods
                            .toList());
                  },
                  child: const Text('적용하기'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
