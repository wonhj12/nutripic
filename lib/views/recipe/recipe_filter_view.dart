import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/refrigerator_container.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_container.dart';
import 'package:nutripic/view_models/recipe/recipe_filter_view_model.dart';
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RefrigeratorSelectContainer(
                    selected: recipeFilterViewModel.storage,
                    onTapRefrigerator: recipeFilterViewModel.onTapRefrigerator,
                    onTapFreezer: recipeFilterViewModel.onTapFreezer,
                    onTapCabinet: recipeFilterViewModel.onTapCabinet,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              const SizedBox(height: 26),
              RefrigeratorContainer(
                foods: recipeFilterViewModel.refrigeratorModel
                    .foods[recipeFilterViewModel.storage.rawValue],
                expiredFoods: recipeFilterViewModel.refrigeratorModel
                    .expiredFoods[recipeFilterViewModel.storage.rawValue],
                selectedFoods: recipeFilterViewModel.filterSelectedFoods,
                selectedExpiredFoods:
                    recipeFilterViewModel.filterSelectedExpiredFoods,
                isSelectable: recipeFilterViewModel.isSelectable = true,
                addFood: () {},
                selectFood: recipeFilterViewModel.selectFood,
              ),
              const SizedBox(height: 16),
            ],
          ),

          // 선택된 식재료 및 "적용하기" 버튼
          if (recipeFilterViewModel.filterSelectedFoods.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeFilterViewModel.filterSelectedFoods.length,
                    itemBuilder: (context, index) {
                      final food = recipeFilterViewModel.filterSelectedFoods
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      recipeFilterViewModel.refrigeratorModel.selectedFoods
                          .toList(),
                    );
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
