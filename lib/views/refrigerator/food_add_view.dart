import 'package:flutter/material.dart';
import 'package:nutripic/components/common/box_button.dart';
import 'package:nutripic/components/refrigerator/food_add_container.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/common/main_button.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
import 'package:nutripic/utils/enums/main_button_type.dart';
import 'package:nutripic/utils/enums/storage_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/refrigerator/food_add_view_model.dart';
import 'package:provider/provider.dart';

class FoodAddView extends StatelessWidget {
  const FoodAddView({super.key});

  @override
  Widget build(BuildContext context) {
    FoodAddViewModel recipeAddViewModel = context.watch<FoodAddViewModel>();

    return CustomScaffold(
      appBar: CustomAppBar(
        title: '분석 결과',
        closeButton: true,
        onPressedLeading: recipeAddViewModel.onPressClose,
        actions: [
          BoxButton(
            label: recipeAddViewModel.isSelectState ? '취소' : '선택',
            onPressed: recipeAddViewModel.onPressSelect,
          ),
        ],
      ),
      canPop: false,
      isLoading: recipeAddViewModel.isLoading,
      body: CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 32),

                // 인식된 식재료 리스트
                FoodAddContainer(
                  title: '냉장보관',
                  recognizedFoods:
                      recipeAddViewModel.cameraModel.analyzedFoods[0],
                  selectedFoods:
                      recipeAddViewModel.cameraModel.selectedRefrigerator,
                  isSelectState: recipeAddViewModel.isSelectState,
                  select: recipeAddViewModel.selectRefrigeratorFood,
                  onTapEdit: (food) => recipeAddViewModel.onPressedEdit(
                    food: food,
                    storage: StorageType.fridge,
                  ),
                ),

                // 인식된 식재료 리스트
                FoodAddContainer(
                  title: '냉동보관',
                  recognizedFoods:
                      recipeAddViewModel.cameraModel.analyzedFoods[1],
                  selectedFoods: recipeAddViewModel.cameraModel.selectedFreezer,
                  isSelectState: recipeAddViewModel.isSelectState,
                  select: recipeAddViewModel.selectFreezerFood,
                  onTapEdit: (food) => recipeAddViewModel.onPressedEdit(
                    food: food,
                    storage: StorageType.freezer,
                  ),
                ),

                // 인식된 식재료 리스트
                FoodAddContainer(
                  title: '실온보관',
                  recognizedFoods:
                      recipeAddViewModel.cameraModel.analyzedFoods[2],
                  selectedFoods: recipeAddViewModel.cameraModel.selectedRoom,
                  isSelectState: recipeAddViewModel.isSelectState,
                  select: recipeAddViewModel.selectRoomFood,
                  onTapEdit: (food) => recipeAddViewModel.onPressedEdit(
                    food: food,
                    storage: StorageType.room,
                  ),
                ),
              ],
            ),
          ),

          // Spacer로 하단 분리
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),

                // 식재료 등록 문구
                if (!recipeAddViewModel.isSelectState)
                  Text(
                    '찾는 재료가 없다면, 식재료를 새로 등록해보세요.',
                    style: Palette.caption2.copyWith(color: Palette.gray400),
                  ),
                if (!recipeAddViewModel.isSelectState)
                  const SizedBox(height: 20),

                // 새 식재료 등록 버튼
                if (!recipeAddViewModel.isSelectState)
                  BoxButton(
                    label: '등록하기',
                    type: BoxButtonType.primary,
                    s: false,
                    onPressed: recipeAddViewModel.onPressedEdit,
                  ),
                if (!recipeAddViewModel.isSelectState)
                  const SizedBox(height: 40),

                // 보관 버튼
                MainButton(
                  label: recipeAddViewModel.isSelectState ? '삭제하기' : '보관하기',
                  type: recipeAddViewModel.isSelectState
                      ? MainButtonType.delete
                      : MainButtonType.enabled,
                  onPressed: recipeAddViewModel.onPressedSave,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
