import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/food_tile.dart';
import 'package:nutripic/objects/food.dart';

class RecentFoodContainer extends StatelessWidget {
  final List<Food> foods;
  const RecentFoodContainer({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return foods.isEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('최근 사용한 식재료가 없어요'),
          )
        : SizedBox(
            height: 94,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: foods.length,
              itemBuilder: (_, index) => FoodTile(
                food: foods.elementAt(index),
                isSelected: false,
                isSelectable: false,
                select: (_) {},
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
            ),
          );
  }
}
