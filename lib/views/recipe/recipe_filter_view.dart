import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/refrigerator_container.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_container.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_filter_view_model.dart';
import 'package:provider/provider.dart';

class RecipeFilterView extends StatelessWidget {
  const RecipeFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeFilterViewModel recipeFilterViewModel =
        context.watch<RecipeFilterViewModel>();

    return CustomScaffold(
      padding: 0,
      appBar: AppBar(
        title: Text(
          "필터 검색",
          style: Palette.subtitle1Medium.copyWith(
            color: Palette.gray00,
          ),
        ),
        backgroundColor: Palette.green500,
        centerTitle: true,
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // 밑줄 높이
          child: Container(
            color: Colors.white, // 밑줄 색상
            height: 0.5, // 밑줄 두께
          ),
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
                        foods: recipeFilterViewModel.refrigeratorModel
                            .foods[recipeFilterViewModel.storage.rawValue],
                        expiredFoods: recipeFilterViewModel
                                .refrigeratorModel.expiredFoods[
                            recipeFilterViewModel.storage.rawValue],
                        selectedFoods:
                            recipeFilterViewModel.filterSelectedFoods,
                        selectedExpiredFoods:
                            recipeFilterViewModel.filterSelectedExpiredFoods,
                        isSelectable: recipeFilterViewModel.isSelectable = true,
                        addFood: () {},
                        selectFood: recipeFilterViewModel.selectFood,
                      ),
                      // 선택된 식재료 및 "적용하기" 버튼
                    ],
                  ),
                ),
              ),
              if (recipeFilterViewModel.filterSelectedFoods.isNotEmpty)
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
                            recipeFilterViewModel.filterSelectedFoods.length,
                        itemBuilder: (context, index) {
                          final food = recipeFilterViewModel.filterSelectedFoods
                              .elementAt(index);
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: Chip(
                              label: Text(
                                food.name,
                                style: Palette.caption3,
                              ),
                              onDeleted: () {
                                recipeFilterViewModel.selectFood(food);
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
                        Navigator.pop(
                          context,
                          recipeFilterViewModel.filterSelectedFoods.toList(),
                        );
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
                        '적용하기',
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
              selected: recipeFilterViewModel.storage,
              onTapRefrigerator: recipeFilterViewModel.onTapRefrigerator,
              onTapFreezer: recipeFilterViewModel.onTapFreezer,
              onTapCabinet: recipeFilterViewModel.onTapCabinet,
            ),
          ),
        ],
      ),
    );
  }
}
