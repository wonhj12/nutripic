import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/refrigerator/food_select.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';

class FoodTile extends StatelessWidget {
  /// 식재료
  final Food food;

  /// 선택 됨 여부
  final bool isSelected;

  /// 식재료 선택 가능 여부
  final bool isSelectable;

  /// 식재료 선택시 콜백 함수
  final Function(Food) select;

  const FoodTile({
    super.key,
    required this.food,
    required this.isSelected,
    required this.isSelectable,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 식재료 선택
      onTap: () => select(food),
      child: SizedBox(
        width: 68,
        height: 94,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // 식재료 사진
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? Palette.green400
                          : food.expired && !isSelectable
                              ? Palette.delete
                              : Palette.gray100,
                      width: 1,
                    ),
                  ),
                  child: SvgPicture.asset('assets/foods/${food.icon}.svg'),
                ),

                // 선택시 체크 표시
                if (isSelectable) FoodSelect(isSelected: isSelected),
              ],
            ),
            const SizedBox(height: 4),

            // 식재료 이름
            Text(
              food.name,
              style: Palette.body2.copyWith(color: Palette.gray900),
            ),
          ],
        ),
      ),
    );
  }
}
