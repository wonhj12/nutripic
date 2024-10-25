import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/refrigerator/food_dday.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';

class FoodTile extends StatelessWidget {
  /// 식재료
  final Food food;

  /// 선택 됨 여부
  final bool isSelected;

  /// 식재료 선택시 콜백 함수
  final Function(Food) select;
  const FoodTile({
    super.key,
    required this.food,
    required this.isSelected,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 식재료 선택
      onTap: () => select(food),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              // 식재료 사진
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Palette.secondary : Palette.gray100,
                      width: 2,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/foods/${food.imageName}.svg',
                  ),
                ),
              ),

              // 선택시 체크 표시
              if (isSelected)
                Positioned(
                  top: 0,
                  right: 13,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Palette.background,
                      shape: BoxShape.circle,
                      border: Border.all(color: Palette.secondary, width: 2),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Palette.secondary,
                      size: 20,
                    ),
                  ),
                ),

              // 식재료 D-day
              Positioned(
                top: 0,
                left: 0,
                child: FoodDday(dDay: food.dDay()),
              ),

              // 식재료 개수
              if (food.count > 1)
                Positioned(
                  bottom: 0,
                  right: 13,
                  child: Container(
                    width: 21,
                    height: 21,
                    decoration: const BoxDecoration(
                      color: Palette.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'x${food.count}',
                        style: Palette.foodCount,
                      ),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 12),

          // 식재료 이름
          Text(food.name, style: Palette.body)
        ],
      ),
    );
  }
}
