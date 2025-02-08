import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/image_button.dart';
import 'package:nutripic/components/refrigerator/icon_selection.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';

class RecognizedFoodTile extends StatelessWidget {
  /// 인식된 식재료
  final Food food;

  /// 선택 모드
  final bool isSelectState;

  /// 선택 됨 여부
  final bool isSelected;

  /// 수정 버튼 클릭시 호출할 함수
  final Function(Food) onTapEdit;

  /// 식재료 선택시 콜백 함수
  final Function(Food) select;

  /// `name = filename.svg`
  const RecognizedFoodTile({
    super.key,
    required this.food,
    required this.isSelectState,
    required this.isSelected,
    required this.onTapEdit,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => select(food),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 선택 버튼
          if (isSelectState) IconSelection(isSelected: isSelected),
          if (isSelectState) const SizedBox(width: 8),

          // 식재료 이미지
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Palette.gray200,
                width: 1,
              ),
            ),
            child: SvgPicture.asset('assets/foods/${food.icon}.svg'),
          ),
          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 유통기한
              Container(
                width: 45,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Palette.delete,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'D-5',
                  style: Palette.caption1.copyWith(color: Palette.gray00),
                ),
              ),
              const SizedBox(height: 6),

              // 식재료 이름
              Text(
                food.name,
                style: Palette.body1.copyWith(color: Palette.gray900),
              ),
            ],
          ),

          const Spacer(),

          // 수정 버튼
          if (!isSelectState)
            ImageButton(
              img: '/edit.svg',
              width: 24,
              height: 24,
              onTap: () => onTapEdit(food),
            ),
        ],
      ),
    );
  }
}
