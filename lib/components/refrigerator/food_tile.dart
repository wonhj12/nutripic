import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/refrigerator/food_dday.dart';
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

  /// 유통기한 표시 여부
  final bool showDday;

  /// 식재료 선택시 콜백 함수
  final Function(Food) select;
  const FoodTile({
    super.key,
    required this.food,
    required this.isSelected,
    required this.isSelectable,
    this.showDday = false,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 식재료 선택
      onTap: () => select(food),
      child: SizedBox(
        width: 64,
        height: 84,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // 식재료 사진
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? Palette.delete : Palette.gray100,
                      width: 1,
                    ),
                  ),
                  child: SvgPicture.asset('assets/foods/${food.icon}.svg'),
                ),

                // 선택시 체크 표시
                if (isSelectable) FoodSelect(isSelected: isSelected),

                // 식재료 D-day
                if (showDday) FoodDday(dDay: food.dDay()),
              ],
            ),
            const SizedBox(height: 10),

            // 식재료 이름
            Text(food.name, style: Palette.body1),
          ],
        ),
      ),
    );
  }
}
