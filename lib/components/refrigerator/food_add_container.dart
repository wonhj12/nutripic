import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/recognized_food_tile.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';

class FoodAddContainer extends StatelessWidget {
  /// 컨테이너 제목
  final String title;

  /// 인식된 식재료 리스트
  final List<Food> recognizedFoods;

  /// 선택된 식재료
  final Set<Food> selectedFoods;

  /// 선택 모드 여부
  final bool isSelectState;

  /// 식재료 선택시 콜백 함수
  final Function(Food) select;

  /// 식재료 수정 함수
  final Function(Food) onTapEdit;

  const FoodAddContainer({
    super.key,
    required this.title,
    required this.recognizedFoods,
    required this.selectedFoods,
    required this.isSelectState,
    required this.select,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return recognizedFoods.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 타이틀
              Text(title, style: Palette.title1Medium),
              const SizedBox(height: 16),

              // 인식한 식재료 컨테이너
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Palette.gray00,
                  border: Border.all(color: Palette.gray200),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recognizedFoods.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Palette.gray100,
                    height: 12,
                  ),
                  itemBuilder: (BuildContext context, int index) =>
                      RecognizedFoodTile(
                    food: recognizedFoods.elementAt(index),
                    isSelectState: isSelectState,
                    isSelected: selectedFoods.contains(recognizedFoods[index]),
                    onTapEdit: onTapEdit,
                    select: select,
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          )
        : Container();
  }
}
