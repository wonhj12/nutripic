import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/select_button.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/refrigerator_container.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_container.dart';
import 'package:nutripic/utils/enums/select_button_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/refrigerator/refrigerator_view_model.dart';
import 'package:provider/provider.dart';

class RecipeFilterView extends StatelessWidget {
  const RecipeFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    RefrigeratorViewModel refrigeratorViewModel =
        context.watch<RefrigeratorViewModel>();

    // 선택 가능 모드 활성화
    refrigeratorViewModel.isSelectable = true;

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
                foods: refrigeratorViewModel.refrigeratorModel
                    .foods[refrigeratorViewModel.storage.rawValue],
                selectedFoods: refrigeratorViewModel.selectedFoods,
                isSelectable: refrigeratorViewModel.isSelectable,
                addFood: null,
                selectFood: refrigeratorViewModel.selectFood,
              ),
              const SizedBox(height: 16),
            ],
          ),
          // 냉장고 선택 버튼
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RefrigeratorSelectContainer(
                selected: refrigeratorViewModel.storage,
                onTapRefrigerator: refrigeratorViewModel.onTapRefrigerator,
                onTapFreezer: refrigeratorViewModel.onTapFreezer,
                onTapCabinet: refrigeratorViewModel.onTapCabinet,
              ),
              const SizedBox(height: 24),
            ],
          ),

          // 선택된 식재료 및 "적용하기" 버튼
          if (refrigeratorViewModel.selectedFoods.isNotEmpty)
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
                    itemCount: refrigeratorViewModel.selectedFoods.length,
                    itemBuilder: (context, index) {
                      final food =
                          refrigeratorViewModel.selectedFoods.elementAt(index);
                      return Chip(
                        label: Text(food.name),
                        onDeleted: () {
                          refrigeratorViewModel.selectFood(food);
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
                        context, refrigeratorViewModel.selectedFoods.toList());
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
