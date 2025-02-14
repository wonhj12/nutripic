import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/refrigerator_container.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_container.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_finish_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class RecipeFinishView extends StatelessWidget {
  const RecipeFinishView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeFinishViewModel recipeFinishViewModel =
        context.watch<RecipeFinishViewModel>();

    return CustomScaffold(
      padding: 0,
      appBar: AppBar(
        backgroundColor: Palette.green500,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/backIcon.svg',
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
            color: Palette.gray00,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 63,
                color: Palette.green500,
              ),
              Expanded(
                child: Container(
                  color: Palette.gray00,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 52,
                      ),
                      Container(
                        alignment: Alignment.centerLeft, // 왼쪽 정렬
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16), // 패딩 추가
                        child: Text(
                          '보유한 식재료',
                          style: Palette.title2SemiBold.copyWith(
                            color: Palette.gray900,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      RefrigeratorContainer(
                        foods: recipeFinishViewModel.refrigeratorModel
                            .foods[recipeFinishViewModel.storage.rawValue],
                        expiredFoods: recipeFinishViewModel
                                .refrigeratorModel.expiredFoods[
                            recipeFinishViewModel.storage.rawValue],
                        selectedFoods:
                            recipeFinishViewModel.filterSelectedFoods,
                        selectedExpiredFoods:
                            recipeFinishViewModel.filterSelectedExpiredFoods,
                        isSelectable: recipeFinishViewModel.isSelectable = true,
                        addFood: () {},
                        selectFood: recipeFinishViewModel.selectFood,
                      ),
                    ],
                  ),
                ),
              ),

              // 선택된 식재료 및 "적용하기" 버튼

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 73,
                    decoration: BoxDecoration(
                      color: Palette.gray00,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC2C0CB)
                              .withOpacity(0.3), // 그림자 색상 및 투명도
                          blurRadius: 10, // 그림자 퍼짐 정도
                          spreadRadius: 0, // 그림자 확산 범위
                          offset: const Offset(0, -3), // 그림자 위치
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          recipeFinishViewModel.filterSelectedFoods.length,
                      itemBuilder: (context, index) {
                        final food = recipeFinishViewModel.filterSelectedFoods
                            .elementAt(index);
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(
                              food.name,
                              style: Palette.caption3,
                            ),
                            onDeleted: () {
                              recipeFinishViewModel.selectFood(food);
                            },
                            backgroundColor: Palette.gray100,
                            side: BorderSide.none,
                            deleteIcon: SvgPicture.asset(
                              'assets/icons/close.svg',
                              width: 8,
                              height: 8,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Palette.gray100, // 밑줄 색상
                    height: 0.5, // 밑줄 두께
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      recipeFinishViewModel.filterSelectedFoods.isNotEmpty
                          ? _showConfirmationDialog(
                              context, recipeFinishViewModel)
                          : context.go('/recipe'); // 다이얼로그 닫기;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.green500,
                      fixedSize: const Size(343, 50), // 버튼 배경색
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      recipeFinishViewModel.filterSelectedFoods.isNotEmpty
                          ? '적용하기'
                          : '건너뛰기',
                      style: Palette.title2SemiBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
          Positioned(
            top: 38,
            child: RefrigeratorSelectContainer(
              selected: recipeFinishViewModel.storage,
              onTapRefrigerator: recipeFinishViewModel.onTapRefrigerator,
              onTapFreezer: recipeFinishViewModel.onTapFreezer,
              onTapCabinet: recipeFinishViewModel.onTapCabinet,
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, RecipeFinishViewModel viewModel) {
    showDialog(
      context: context,
      barrierDismissible: true, // 배경 클릭 시 닫기 가능
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/danger.svg',
                    width: 14,
                    height: 14,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    '해당 식재료들을 삭제하시겠어요?',
                    style: Palette.title2Medium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '식재료명',
                    style:
                        Palette.caption1.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '날짜',
                    style:
                        Palette.caption1.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                color: Palette.gray100, // 밑줄 색상
                height: 1, // 밑줄 두께
              ),
              const SizedBox(
                height: 4,
              ),
              ...viewModel.filterSelectedFoods.map((food) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(food.name),
                    Text(
                      food.expireDate.toString().substring(0, 10),
                      style: Palette.caption1,
                    ),
                  ],
                );
              }),
            ],
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16), // 버튼 패딩

          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
            )
          ],
        );
      },
    );
  }
}
