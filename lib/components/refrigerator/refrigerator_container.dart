import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/food_tile.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';

class RefrigeratorContainer extends StatelessWidget {
  /// 전체 식재료 리스트
  final List<Food> foods;

  /// 선택된 식재료 set (중복 방지)
  final Set<Food> selectedFoods;

  /// 식재료 선택 가능 여부
  final bool isSelectable;

  /// 새로운 식재로 추가
  final Function()? addFood;

  /// 식재료 선택시 콜백 함수
  final Function(Food) selectFood;
  const RefrigeratorContainer({
    super.key,
    required this.foods,
    required this.selectedFoods,
    required this.isSelectable,
    required this.addFood,
    required this.selectFood,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 32),
        decoration: BoxDecoration(
          color: Palette.background,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [Palette.shadow],
        ),
        child: foods.isEmpty
            // 식재료 리스트가 없으면 추가 버튼 생성
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: addFood,
                      icon: const Icon(
                        Icons.add_circle_rounded,
                        size: 56,
                        color: Palette.green500,
                      ),
                    ),
                    const Text('식재료를 추가해보세요', style: Palette.body1),
                  ],
                ),
              )
            // 식재료 리스트가 있으면 GridView 생성
            : GridView.builder(
                shrinkWrap: true,
                itemCount: foods.length,
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 10,
                ),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 22,
                  crossAxisCount: 4,
                  childAspectRatio: 64 / 84,
                ),
                itemBuilder: (context, foodIndex) {
                  return FoodTile(
                    food: foods[foodIndex],
                    isSelected: selectedFoods.contains(foods[foodIndex]),
                    isSelectable: isSelectable,
                    showDday: foods[foodIndex].showDday(),
                    select: selectFood,
                  );
                },
              ),
      ),
    );
  }
}
