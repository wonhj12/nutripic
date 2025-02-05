import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                    _showConfirmationDialog(context, recipeFinishViewModel);
                  },
                  child: const Text('적용하기'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// 작은 확인 창을 띄우는 함수
  void _showConfirmationDialog(
      BuildContext context, RecipeFinishViewModel viewModel) {
    showDialog(
      context: context,
      barrierDismissible: true, // 배경 클릭 시 닫기 가능
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('삭제 확인'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('선택한 음식을 삭제하시겠습니까?'),
              const SizedBox(height: 16),
              ...viewModel.filterSelectedFoods.map((food) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(food.name),
                    Text(
                      food.expireDate.toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                // 선택한 음식을 삭제
                Navigator.pop(context); // 다이얼로그 닫기

                context.go('/recipe'); // 다이얼로그 닫기
                // 화면 닫기
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
