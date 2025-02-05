import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/refrigerator_container.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_container.dart';
import 'package:nutripic/view_models/recipe/recipe_finish_view_model.dart';
import 'package:provider/provider.dart';

class RecipeFinishView extends StatelessWidget {
  const RecipeFinishView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeFinishViewModel recipeFinishViewModel =
        context.watch<RecipeFinishViewModel>();

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
                    selected: recipeFinishViewModel.storage,
                    onTapRefrigerator: recipeFinishViewModel.onTapRefrigerator,
                    onTapFreezer: recipeFinishViewModel.onTapFreezer,
                    onTapCabinet: recipeFinishViewModel.onTapCabinet,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              const SizedBox(height: 26),
              RefrigeratorContainer(
                foods: recipeFinishViewModel.refrigeratorModel
                    .foods[recipeFinishViewModel.storage.rawValue],
                expiredFoods: recipeFinishViewModel.refrigeratorModel
                    .expiredFoods[recipeFinishViewModel.storage.rawValue],
                selectedFoods: recipeFinishViewModel.filterSelectedFoods,
                selectedExpiredFoods:
                    recipeFinishViewModel.filterSelectedExpiredFoods,
                isSelectable: recipeFinishViewModel.isSelectable = true,
                addFood: () {},
                selectFood: recipeFinishViewModel.selectFood,
              ),
              const SizedBox(height: 16),
            ],
          ),

          // 선택된 식재료 및 "적용하기" 버튼
          if (recipeFinishViewModel.filterSelectedFoods.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeFinishViewModel.filterSelectedFoods.length,
                    itemBuilder: (context, index) {
                      final food = recipeFinishViewModel.filterSelectedFoods
                          .elementAt(index);
                      return Chip(
                        label: Text(food.name),
                        onDeleted: () {
                          recipeFinishViewModel.selectFood(food);
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      recipeFinishViewModel.filterSelectedFoods.toList(),
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
