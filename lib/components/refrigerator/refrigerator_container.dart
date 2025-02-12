import 'package:flutter/material.dart';
import 'package:nutripic/components/box_button.dart';
import 'package:nutripic/components/refrigerator/food_tile.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
import 'package:nutripic/utils/palette.dart';

class RefrigeratorContainer extends StatelessWidget {
  /// 전체 식재료 리스트
  final List<Food> foods;

  /// 유통기한 임박 식재료 리스트
  final List<Food> expiredFoods;

  /// 선택된 식재료 set (중복 방지)
  final Set<Food> selectedFoods;

  /// 선택된 유통기한 임박 식재료 set
  final Set<Food> selectedExpiredFoods;

  /// 식재료 선택 가능 여부
  final bool isSelectable;

  /// 새로운 식재로 추가
  final Function()? addFood;

  /// 식재료 선택시 콜백 함수
  final Function(Food) selectFood;

  const RefrigeratorContainer({
    super.key,
    required this.foods,
    required this.expiredFoods,
    required this.selectedFoods,
    required this.selectedExpiredFoods,
    required this.isSelectable,
    required this.addFood,
    required this.selectFood,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: foods.isEmpty
          // 식재료 리스트가 없으면 추가 버튼 생성
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '냉장고가 텅 비었어요',
                    style: Palette.subtitle1SemiBold
                        .copyWith(color: Palette.gray900),
                  ),
                  const SizedBox(height: 24),
                  BoxButton(
                    width: 114,
                    label: '식재료 추가하기',
                    type: BoxButtonType.primary,
                    onPressed: addFood,
                  )
                ],
              ),
            )
          // 식재료 리스트가 있으면 GridView 생성
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 11.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (expiredFoods.isNotEmpty)
                    // 유통기한 임박
                    Row(
                      children: [
                        Text(
                          '유통기한 임박',
                          style: Palette.subtitle1Medium
                              .copyWith(color: Palette.gray900),
                        ),
                        const SizedBox(width: 8),

                        // Tooltip
                        Tooltip(
                          message:
                              '유통기한이 3일 미만으로 남은 식재료에요.\n탭해서 권장 유통기한을 확인해보세요.',
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Palette.gray900,
                          ),
                          height: 56,
                          padding: const EdgeInsets.all(8),
                          textStyle:
                              Palette.caption2.copyWith(color: Palette.gray00),
                          showDuration: const Duration(seconds: 2),
                          waitDuration: const Duration(seconds: 1),
                          preferBelow: false,
                          verticalOffset: 16,
                          triggerMode: TooltipTriggerMode.tap,
                          child: const Icon(
                            Icons.error_rounded,
                            size: 14,
                            color: Palette.gray300,
                          ),
                        )
                      ],
                    ),
                  if (expiredFoods.isNotEmpty) const SizedBox(height: 12),

                  // 유통기한 임박 식재료 좌우 스크롤 컨테이너
                  if (expiredFoods.isNotEmpty)
                    SizedBox(
                      height: 98,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: expiredFoods.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) => FoodTile(
                          food: expiredFoods[index],
                          isSelected: selectedExpiredFoods
                              .contains(expiredFoods[index]),
                          isSelectable: isSelectable,
                          select: selectFood,
                        ),
                      ),
                    ),
                  if (expiredFoods.isNotEmpty) const SizedBox(height: 30),

                  // 보유 식재료
                  if (expiredFoods.isNotEmpty)
                    Text(
                      '보유 식재료',
                      style: Palette.subtitle1Medium
                          .copyWith(color: Palette.gray900),
                    ),

                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: foods.length,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 16,
                      crossAxisCount: 4,
                      mainAxisExtent: 94,
                    ),
                    itemBuilder: (context, foodIndex) {
                      return FoodTile(
                        food: foods[foodIndex],
                        isSelected: selectedFoods.contains(foods[foodIndex]),
                        isSelectable: isSelectable,
                        select: selectFood,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
